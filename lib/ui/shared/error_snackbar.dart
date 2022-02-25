import 'package:flutter/material.dart';

class AppSnackBar {
  /// Creating a global key for [ScaffoldMessengerState] 
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

 ///Used to show snackbar using [ScaffoldMessengerState] so it can be called anywhere in the app.
  static showErrorSnackBar(String message) {
    if (rootScaffoldMessengerKey.currentState != null) {
      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
