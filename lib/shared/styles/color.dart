import 'package:flutter/material.dart';

import '../network/local/cache_helper.dart';

class AppColor {
  static const Color primary1Color = Color(0xFF097BED); // #097bed
  static const Color primary2Color = Color(0xFFFFBE00); // #ffbe00
  static const Color secondary1Color = Color(0xFFFFFFFF); // #ffffff
  static const Color secondary2Color = Color(0xFFF2F2F2); // #F2F2F2



  static const Color blackColor = Color(0xFF181725);

  static const Color blueColor = Color(0xFF0C1892);
  static const Color greyColor = Color(0xFF7E7E7E);
  static const Color greySuccessColor = Color(0xFF7C7C7C);

  static const Color yellowColor = Color(0xFFC0FF00);
  static const Color greyLight = Color(0xFFF3F5F7);
  static const Color borderButton = Color(0xFFF1F1F5);
  static const Color borderInput = Color(0xFFE2E2E2);
  static const Color facebookColor = Color(0xFF1877F2);
  static const Color borderMedia = Color(0xFFDADCE0);
  static const Color backgroundProduct = Color(0xFFF2F3F2);
  static const Color redColor = Color(0xFF920C0C);
  static const Color lightRedColor = Color.fromARGB(25, 146, 12, 12);
  static const Color lightBlueColor = Color(0xFFE7E8F4);


//background: ########920C0C;

//F2994A





}


class ThemeComponent {
  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: AppColor.blueColor,
        onPrimary: Colors.white,
        onSurface: AppColor.blueColor,
        background: Colors.white,
        onBackground: Colors.white,
      ),
      fontFamily: CacheHelper.getData(key: 'locale') == "ar"? "Almarai" :"Inter",
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: Colors.white,
        todayForegroundColor: MaterialStateColor.resolveWith(
                (states) => AppColor.greyColor),
        todayBorder: BorderSide.none,
        confirmButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
                  (states) => AppColor.blueColor),
        ),
        cancelButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
                  (states) => AppColor.blueColor),
        ),
        dayOverlayColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        rangeSelectionOverlayColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        rangePickerShadowColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        rangePickerHeaderBackgroundColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        rangePickerHeaderForegroundColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        shadowColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        rangePickerSurfaceTintColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        surfaceTintColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        yearBackgroundColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        rangeSelectionBackgroundColor: AppColor.blueColor,
        rangePickerBackgroundColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blueColor),
        todayBackgroundColor: MaterialStateColor.resolveWith(
              (states) => AppColor.blueColor,
        ),
      ),
      dataTableTheme: DataTableThemeData(
        dataRowColor: MaterialStateColor.resolveWith(
                (states) => AppColor.blackColor),
      ),
      primaryColorDark: AppColor.blueColor,
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        cancelButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
                  (states) => AppColor.blackColor),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
                  (states) => AppColor.blueColor),
        ),
        dialBackgroundColor: Colors.white,
        dialHandColor: AppColor.blueColor,
        dialTextColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.selected)
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}

