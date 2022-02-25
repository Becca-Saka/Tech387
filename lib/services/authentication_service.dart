import 'package:tech387/ui/shared/constants.dart';
import 'package:uuid/uuid_util.dart';

class AuthenticationService {
  final auth = Amplify.Auth;
  final dataStore = Amplify.DataStore;

  ///Cheking if user is logged in and getting user data
  Future<UserModel?> getCurrentUser() async {
    try {
      final AuthSession res = await auth.fetchAuthSession();
      if (res.isSignedIn) {
        final user = await getUserFromDatabase();
        if (user != null) {
          return user;
        }
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> getUserFromDatabase() async {
    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
      final user = await dataStore.query(UserModel.classType,
          where: UserModel.ID.eq(currentUser.userId));
      if (user.isNotEmpty) {
        return user.first;
      }
    } on Exception {
      return null;
    }
    return null;
  }

  ///Checking if username is already taken
  Future<bool> checkUserName(
    String userName,
  ) async {
    List<UserModel> user = await dataStore.query(UserModel.classType,
        where: UserModel.USERNAMEQUERY.contains(userName.toLowerCase()));
    return user.isNotEmpty;
  }

  ///Generate a random user name for user using social logins
  String _generateUUID() {
    final id = const Uuid().v4(options: {
      'rng': UuidUtil.cryptoRNG,
    });
    final mappedId = id.replaceAll('-', '');
    final firstpartofId = mappedId.substring(0, 16);
    return firstpartofId;
  }

  Future<UserModel?> signUpWithEmail(
      String email, String password, String userName) async {
    try {
      SignUpResult result = await auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: {
            CognitoUserAttributeKey.email: email,
            CognitoUserAttributeKey.preferredUsername: userName,
          }));
      if (result.isSignUpComplete) {
        final user = await signInWithEmail(email, password);
        if (user) {
          return await _saveUserToDataBase(
            email,
            userName,
          );
        }
      }
    } on AmplifyException catch (e) {
      AppSnackBar.showErrorSnackBar(getErrorMessage(e.message));
      return null;
    }
    return null;
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      await auth.signOut();
      final result = await auth.signIn(
        username: email,
        password: password,
      );
      return result.isSignedIn;
    } on AmplifyException catch (e) {
      AppSnackBar.showErrorSnackBar(getErrorMessage(e.message));
      return false;
    }
  }

  Future<UserModel> _saveUserToDataBase(String email, String userName,
      {String? familyName, String? givenName, String? picture}) async {
    final currentUser = await Amplify.Auth.getCurrentUser();

    ///Removing spacing from user name
    userName = userName.split(" ").join("");

    final userNameExist = await checkUserName(userName);
    if (userNameExist) {
      userName = userName + _generateUUID();
    }
    final user = UserModel(
      email: email,
      lastName: familyName,
      firstName: givenName,
      socialProfileImage: picture,
      userName: userName,
      userNameQuery: userName.toLowerCase(),
      id: currentUser.userId,
    );
    await dataStore.save(user);
    return user;
  }

  ///Gets image url from storage using image key
  Future<String> getImageUrlFromKey(String key) async {
    const tokenExpires = 7 * 24 * 60 * 60;
    final GetUrlResult urlResult = await Amplify.Storage.getUrl(
        key: key,
        options: GetUrlOptions(
            accessLevel: StorageAccessLevel.protected, expires: tokenExpires));
    return urlResult.url;
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      await auth.signOut();
      SignInResult result = await auth.signInWithWebUI(
        provider: AuthProvider.google,
      );
      if (result.isSignedIn) {
        List<AuthUserAttribute> authUserAttributes =
            await auth.fetchUserAttributes();
        String userId = authUserAttributes[0].value;
        String userName = authUserAttributes[3].value;
        String givenName = authUserAttributes[4].value;
        String familyName = authUserAttributes[5].value;
        String email = authUserAttributes[6].value;
        String picture = authUserAttributes[7].value;

        return await _handleAuthenticatedUser(
            userId, email, userName, familyName, givenName, picture);
      }
      return null;
    } on AmplifyException catch (e) {
      AppSnackBar.showErrorSnackBar(getErrorMessage(e.message));
      return null;
    }
  }

  Future<UserModel> _handleAuthenticatedUser(
      String userId,
      String email,
      String userName,
      String familyName,
      String givenName,
      String picture) async {
    List<UserModel> user = await dataStore.query(UserModel.classType,
        where: UserModel.ID.eq(userId));
    if (user.isNotEmpty) {
      return user.first;
    } else {
      return await _saveUserToDataBase(
        email,
        userName,
        familyName: familyName,
        givenName: givenName,
        picture: picture,
      );
    }
  }

  Future<UserModel?> signInWithFacebook() async {
    try {
      await auth.signOut();
      var result = await auth.signInWithWebUI(
        provider: AuthProvider.facebook,
      );
      if (result.isSignedIn) {
        List<AuthUserAttribute> authUserAttributes =
            await auth.fetchUserAttributes();
        String userId = authUserAttributes[0].value;
        String userName = authUserAttributes[3].value;
        String givenName = authUserAttributes[4].value;
        String familyName = authUserAttributes[5].value;
        String email = authUserAttributes[6].value;
        final pictureData = authUserAttributes[7].value;
        final decodedPicture = jsonDecode(pictureData);
        final picture = decodedPicture['data']['url'];
        return await _handleAuthenticatedUser(
            userId, email, userName, familyName, givenName, picture);
      }
      return null;
    } on AmplifyException catch (e) {
      AppSnackBar.showErrorSnackBar(getErrorMessage(e.message));
      return null;
    }
  }

  signOut() async => await auth.signOut();

  Future<void> updateUserInDataBase(UserModel user) async =>
      await dataStore.save(
        user,
      );

  Future<String> uploadImageToStorage(String path, String key) async {
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: File(path),
        key: key,
        options: UploadFileOptions(
          accessLevel: StorageAccessLevel.protected,
        ),
      );
      return result.key;
    } on AmplifyException catch (e) {
      AppSnackBar.showErrorSnackBar(getErrorMessage(e.message));
      rethrow;
    }
  }

  ///Getting [AmplifyException] error message and mapping it to a readable message
  String getErrorMessage(String error) {
    String message = "";

    switch (error) {
      case "Failed since user is not authorized.":
        message = "Incorrect username or password";

        break;
      case "User not found in the system.":
        message = "Account not found, please sign up";
        break;
      case "Username already exists in the system":
        message = "Email already exists, please sign in";
        break;
      default:
        "Something went wrong, please try again";
    }

    return message;
  }
}
