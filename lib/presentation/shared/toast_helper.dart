import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {ToastType type = ToastType.error}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: {
        ToastType.error: Colors.red,
        ToastType.info: Colors.blue,
        ToastType.success: Colors.green
      }[type],
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastType { error, info, success }
