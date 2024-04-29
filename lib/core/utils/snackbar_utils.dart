import 'package:flutter/material.dart';
import 'package:mmm_project/main.dart';

class SnackBarUtils {
  static void showMessage(String content) {
    MyApp.scaffoldMessengerKey.currentState!
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
