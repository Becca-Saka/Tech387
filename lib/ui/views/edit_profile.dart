import 'package:tech387/ui/shared/constants.dart';
import 'package:tech387/ui/views/address_search_view.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    UserModel user = authProvider.currentUser;

    return WillPopScope(
      onWillPop: () async {
        if (authProvider.isLoading) {
          AppSnackBar.showErrorSnackBar(
              'Please wait for profile to be updated');
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (authProvider.isLoading) {
                AppSnackBar.showErrorSnackBar(
                    'Please wait for profile to be updated');
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          title: const Text('Edit Profile',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: authProvider.pickImage,
                          child: Hero(
                            tag: 'edit',
                            child: Center(
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: authProvider.imagePath !=
                                            null
                                        ? FileImage(
                                            File(authProvider.imagePath!))
                                        : user.socialProfileImage != null
                                            ? NetworkImage(
                                                user.socialProfileImage!)
                                            : const AssetImage(
                                                    'assets/images/logo.png')
                                                as ImageProvider,
                                  ),
                                  const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: appColor,
                                    child: Icon(Icons.camera_alt,
                                        color: secondaryColor, size: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        AppInput(
                          label: 'Username',
                          initialValue: user.userName,
                          enabled: false,
                        ),
                        const Spacer(),
                        AppInput(
                          label: 'First Name',
                          initialValue: user.firstName,
                          validator: Validator.nameValidator,
                          onChanged: authProvider.updateFirstName,
                        ),
                        const Spacer(),
                        AppInput(
                          label: 'Last Name',
                          initialValue: user.lastName,
                          validator: Validator.nameValidator,
                          onChanged: authProvider.updateLastName,
                        ),
                        const Spacer(),
                        AppInput(
                          label: 'Email',
                          enabled: false,
                          initialValue: user.email,
                          validator: Validator.emailValidator,
                          onChanged: authProvider.updateEmail,
                        ),
                        const Spacer(),
                        AppInput(
                          label: 'Address',
                          readOnly: true,
                          controller: TextEditingController(
                              text: authProvider.address ?? user.address),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const AddressSearchView()));
                          },
                        ),
                        const SizedBox(height: 10),
                        AuthButton(
                          title: 'Save',
                          isLoading: authProvider.isLoading,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                            authProvider.updateUserInfo();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
