import 'package:flutter/services.dart';
import 'package:tech387/ui/views/home_view.dart';
import 'package:tech387/ui/shared/constants.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Hero(
          tag: 'Signup',
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
          ),
        ),
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
                      const Text('Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Spacer(),
                      AppInput(
                        label: 'Username',
                        onChanged: authProvider.updateUserName,
                        validator: (val) {
                          return Validator.userNameValidator(
                              val, authProvider.userNameExists);
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                      ),
                      const Spacer(),
                      AppInput(
                        label: 'Email',
                        validator: Validator.emailValidator,
                        onChanged: authProvider.updateEmail,
                      ),
                      const Spacer(),
                      AppInput(
                        label: 'Password',
                        validator: Validator.passwordValidator,
                        onChanged: authProvider.updatePassword,
                        obsureText: authProvider.obsureText,
                        suffixIcon: IconButton(
                          icon: Icon(authProvider.obsureText
                              ? Icons.lock_open
                              : Icons.lock, color: Colors.grey,),
                          onPressed: authProvider.obsurePassword,
                        ),
                      ),
                      const Spacer(),
                      AppInput(
                        label: 'Confirm Password',
                        validator: (val) {
                          return Validator.confirmPasswordValidation(
                              authProvider.password, val);
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obsureText: authProvider.obsureText,
                        suffixIcon: IconButton(
                          icon: Icon(authProvider.obsureText
                              ? Icons.lock_open
                              : Icons.lock, color: Colors.grey,),
                          onPressed: authProvider.obsurePassword,
                        ),
                      ),
                      const SizedBox(height: 60),
                      RichText(
                        text: const TextSpan(
                          text: 'By clicking Sign Up, you agree to our ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: secondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' and have read  ',
                            ),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: TextStyle(
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      AuthButton(
                        title: 'Sign Up',
                        isLoading: authProvider.isLoading,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await authProvider.checkUserNameExists();
                          if (_formKey.currentState!.validate()) {
                            final result =
                                await authProvider.signupUserWithEmail();
                            if (result) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeView()),
                                  (route) => false);
                            }
                          }
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
