import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color colorText;
  final Color colorBorder;
  final Color colorBackGround;
  final String text;
  final double paddingVertical;
  final double paddingHorizontal;
  final double borderRadius;
  final double? width;
  final String? icon;
  final void Function()? onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.colorBackGround,
      required this.colorText,
      required this.colorBorder,
      this.onPressed,
      required this.paddingVertical,
      required this.paddingHorizontal,
      required this.borderRadius,
      this.width,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      width: width,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(colorBackGround),
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: paddingVertical)),
              foregroundColor: WidgetStateProperty.all<Color>(colorBorder),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(color: colorBorder)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    icon!,
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
              Text(
                text,
                style: TextStyle(
                  height: 1.3,
                  color:colorText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: CacheHelper.getData(key: 'locale') == "ar"? "Almarai" :"Inter",
                ),
              ),
            ],
          )),
    );
  }
}
