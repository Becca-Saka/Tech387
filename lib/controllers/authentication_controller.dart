import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tech387/ui/shared/constants.dart';

class AuthenticationController extends ChangeNotifier {
  UserModel get currentUser => _user;
  UserModel _user = UserModel();
  final AuthenticationService _authService = AuthenticationService();
  List<dynamic> addressSuggestions = [];
  GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey();
  String? _username, password;
  String? _email, _firstName, _lastName;
  String? address, _sessionToken;
  bool isLoggedIn = false;
  String? imagePath;
  bool userNameExists = false;
  List<UserModel> searchedUsers = [];
  bool isLoading = false, obsureText = false;

  Future<bool> getSignedIn() async {
    UserModel? result = await _authService.getCurrentUser();
    if (result != null) {
      if (result.profileImageKey != null) {
        final imageUrl =
            await _authService.getImageUrlFromKey(result.profileImageKey!);
        result = result.copyWith(socialProfileImage: imageUrl);
      }
      _user = result;
      address = _user.address;
      return true;
    }
    return false;
  }

  updateUserName(String name) {
    _username = name;
    userNameExists = false;
  }

  updatePassword(String pass) => password = pass;

  updateEmail(String email) => _email = email;

  void updateFirstName(String name) => _firstName = name;

  void updateLastName(String name) => _lastName = name;

  clearFields() {
    _username = null;
    password = null;
    _email = null;
    _firstName = null;
    _lastName = null;
    address = null;
    imagePath = null;
    userNameExists = false;
    addressSuggestions = [];
    isLoading = false;
    obsureText = false;
  }

  Future<bool> checkUserNameExists() async {
    if (_username != null) {
      userNameExists = await _authService.checkUserName(_username!);
      notifyListeners();
    }
    return userNameExists;
  }

  Future<bool> signInUserWithEmail() async {
    setLoadingState(true);
    final result = await _authService.signInWithEmail(_email!, password!);
    if (result) {
      final userr = await _authService.getUserFromDatabase();
      if (userr != null) {
        _user = userr;
        address = _user.address;
        clearFields();
        setLoadingState(false);
        notifyListeners();
        return true;
      }
    }
    setLoadingState(false);
    return false;
  }

  setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  void obsurePassword() {
    if (obsureText) {
      obsureText = false;
    } else {
      obsureText = true;
    }
    notifyListeners();
  }

  Future<bool> signupUserWithEmail() async {
    setLoadingState(true);
    final result =
        await _authService.signUpWithEmail(_email!, password!, _username!);
    if (result != null) {
      _user = result;
      clearFields();
      setLoadingState(false);
      return true;
    }

    setLoadingState(false);
    return false;
  }

  Future<bool> signInUserGoogle() async {
    final result = await _authService.signInWithGoogle();
    if (result != null) {
      _user = result;
      return true;
    }
    return false;
  }

  Future<bool> signInUserFacebook() async {
    final result = await _authService.signInWithFacebook();
    if (result != null) {
      _user = result;
      return true;
    }
    return false;
  }

  String concateName(String? firstName, String? lastName) {
    String name = '';
    if (firstName != null && lastName != null) {
      name = '$firstName $lastName';
    } else if (firstName != null) {
      name = firstName;
    } else if (lastName != null) {
      name = lastName;
    } else {
      name = 'Name';
    }
    return name.toUpperCase();
  }

  Future<void> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      notifyListeners();
    }
  }

  updateUserInfo() async {
    setLoadingState(true);
    String? key, imageUrl;
    if (imagePath != null) {
      key = await _authService.uploadImageToStorage(
          imagePath!, '${currentUser.userName}${currentUser.id}.png');
      imageUrl = await _authService.getImageUrlFromKey(key);
    }
    final user = UserModel(
      userName: _username ?? currentUser.userName,
      firstName: _firstName ?? currentUser.firstName,
      lastName: _lastName ?? currentUser.lastName,
      address: address ?? currentUser.address,
      socialProfileImage: imageUrl ?? currentUser.socialProfileImage,
      profileImageKey: key ?? currentUser.profileImageKey,
      id: currentUser.id,
      userNameQuery: currentUser.userNameQuery,
      email: currentUser.email,
    );
    await Future.delayed(const Duration(seconds: 2));
    await _authService.updateUserInDataBase(user);
    _user = user;
    setLoadingState(false);
  }

  void searchAddress(String value) {
    ///Getting session token to hangle request to google api
    _sessionToken ??= const Uuid().v4();
    _getSuggestion(value);
    notifyListeners();
  }

  ///Getting address suggestions from google api
  void _getSuggestion(String input) async {
    String googlePlacesApi = 'AIzaSyD-WPxwCJvZt26445I4qHT5B1KPq_X7po8';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$googlePlacesApi&sessiontoken=$_sessionToken&types=address';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      addressSuggestions = json.decode(response.body)['predictions'];
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  pickAddress(String add) {
    address = add;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = UserModel();
    clearFields();
  }
}
