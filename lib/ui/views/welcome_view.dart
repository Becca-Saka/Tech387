import 'package:tech387/ui/views/home_view.dart';
import 'package:tech387/ui/views/sign_in_view.dart';
import 'package:tech387/ui/views/sign_up_view.dart';
import 'package:tech387/ui/shared/constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  )),
              const SizedBox(height: 20),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text('Get started by creating your account.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  )),
              const Spacer(),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: socialAuthButtons(
                            'Google', 'assets/images/google.png', () async {
                      final result = await authProvider.signInUserGoogle();
                      if (result) {
                        _navigateToHome(context);
                      }
                    })),
                    const SizedBox(width: 30),
                    Expanded(
                        child: socialAuthButtons(
                            'Facebook', 'assets/images/facebook.png', () async {
                      final result = await authProvider.signInUserFacebook();
                      if (result) {
                        _navigateToHome(context);
                      }
                    })),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 50,
                    child: Divider(
                      color: appColor,
                      thickness: 0.4,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text('or'),
                  ),
                  Divider(
                    color: appColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    width: 50,
                    child: Divider(
                      color: appColor,
                      thickness: 0.4,
                    ),
                  ),
                ],
              ),
              Hero(
                tag: 'Signup',
                child: Material(
                  type: MaterialType.transparency,
                  child: AuthButton(
                   title: 'Signup with email',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpView(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Hero(
                tag: 'signin',
                child: Material(
                  type: MaterialType.transparency,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  SignInView(),
                          ),
                        );
                      },
                      child: RichText(
                          text: const TextSpan(
                        text: 'Existing user? ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
      (route) => false,
    );
  }

  SizedBox socialAuthButtons(String name, String image, Function() onTap) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0.3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: appColor.withOpacity(0.1)),
            ),
            primary: Colors.white),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 18,
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
