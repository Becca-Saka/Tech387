import 'package:tech387/ui/views/home_view.dart';
import 'package:tech387/ui/views/welcome_view.dart';
import 'package:tech387/ui/shared/constants.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  Future<void> didChangeDependencies() async {
    await _checkLogin();
    super.didChangeDependencies();
  }

  Future<void> _checkLogin() async {
    final auth = Provider.of<AuthenticationController>(context);
    final status = await auth.getSignedIn();
    if (status) {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const WelcomeView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Container(
        color: appColor,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          width: width * 0.35,
          height: height * 0.35,
        ),
      ),
    );
  }
}
