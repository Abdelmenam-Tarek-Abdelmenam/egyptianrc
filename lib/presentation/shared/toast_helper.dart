import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message,
    {ToastType type = ToastType.error, bool custom = false, fToast = FToast}) {
  if (!custom) {
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
      fontSize: 16.0,
    );
  } else {
    fToast.showToast(
      child: Text(message),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: child,
          ),
        );
      },
    );
  }
}

enum ToastType { error, info, success }
