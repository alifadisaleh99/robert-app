import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:robquiz/shared/styles/color.dart';

void showToast({
  required String text,
  required ToastStates state,
  bool isNoti = false,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor:  Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING, NOTIFICATION }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.NOTIFICATION:
      color = AppColor.blackColor;
      break;
  }

  return color;
}
