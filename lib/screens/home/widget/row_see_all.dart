import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/styles/color.dart';

class RowSeeAll extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const RowSeeAll({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.blackColor,
          ),
          GestureDetector(
            onTap: onTap,
            child: CustomText(
              text: S.of(context).Seeall,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.primary1Color,
            ),
          ),
        ],
      ),
    );
  }
}
