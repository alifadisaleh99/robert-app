import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
import 'package:robquiz/shared/styles/color.dart';

class CustomSearchFeild extends StatelessWidget {
  final void Function()? onPressedIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  const CustomSearchFeild({super.key, this.onPressedIcon, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.borderInput, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        onChanged:onChanged ,

        decoration: InputDecoration(
          hintText: S.of(context).Searchbytestname,
          hintStyle: TextStyle(
            color: AppColor.greyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: CacheHelper.getData(key: 'locale') == "ar"? "Almarai" :"Inter",
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          border: InputBorder.none,
          suffixIcon: IconButton(onPressed: onPressedIcon, icon: Icon(Icons.search, color: AppColor.blueColor)),

        ),
      ),
    );
  }
}
