
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/styles/image_assets.dart';

import '../styles/color.dart';

class EmptyContainer extends StatelessWidget {
  final String titleEmpty;
  final String bodyEmpty;

  const EmptyContainer({super.key, required this.titleEmpty, required this.bodyEmpty});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.backgroundProduct)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImageAsset.emptyIcon,
          width: 40.h,
            height: 40.h,
          ),
          SizedBox(height: 8.h,),
          CustomText(
            text: titleEmpty,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.blackColor,
          ),
          SizedBox(height: 5.h,),
          CustomText(
            textAlign: TextAlign.center,
            text: bodyEmpty,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.greySuccessColor,
          )

        ],
      ),
    );
  }
}
