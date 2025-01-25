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
      timeInSecForIosWeb: 6,
      backgroundColor: AppColor.blueColor,
      textColor: chooseToastColor(state),
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING, NOTIFICATION }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = AppColor.blueColor;
      break;
    case ToastStates.ERROR:
      color = AppColor.yellowColor;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.NOTIFICATION:
      color = AppColor.blueColor;
      break;
  }

  return color;
}
