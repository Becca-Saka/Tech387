import 'package:tech387/services/amplify_service.dart';
import 'package:tech387/ui/views/startup_view.dart';
import 'package:tech387/ui/shared/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmplifyService.instance.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationController(),
      child: MaterialApp(
        scaffoldMessengerKey: AppSnackBar.rootScaffoldMessengerKey,
        title: 'Tech387',
        theme: ThemeData(
          fontFamily: 'Rubik',
          primarySwatch: Colors.blue,
        ),
        home: const StartUpView(),
      ),
    );
  }
}
