import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
import 'package:robquiz/shared/styles/color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  const CustomText( {
    super.key,
    this.text = '',
    this.fontSize = 12,
    this.color = AppColor.blackColor,
    this.fontWeight = FontWeight.w500, this.textAlign=TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      style: TextStyle(
        height: 1.3,
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        fontFamily: CacheHelper.getData(key: 'locale') == "ar"? "Almarai" :"Inter",
      ),
    );
  }
}
