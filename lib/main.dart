import 'dart:developer';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech387/controllers/authentication_controller.dart';
import 'package:tech387/models/ModelProvider.dart';
import 'package:tech387/ui/shared/error_snackbar.dart';
import 'package:tech387/ui/views/startup_view.dart';
import 'package:amplify_api/amplify_api.dart';
import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(const MyApp());
}

Future<void> configureAmplify() async {
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  final AmplifyStorageS3 _storagePlugin = AmplifyStorageS3();

  await Amplify.addPlugins(
      [_dataStorePlugin, _apiPlugin, _authPlugin, _storagePlugin]);

  try {
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    log('Amplify already configured');
  }
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