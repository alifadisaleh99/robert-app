import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/styles/color.dart';

class CategoryCard extends StatelessWidget {
  final String categoryImage;
  final String categoryTitle;

  const CategoryCard({super.key, required this.categoryImage, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColor.greyLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CachedNetworkImage(imageUrl: categoryImage,height: 35.h,width: 35.h,fit:BoxFit.cover ,

            ),
          ),
        ),
        SizedBox(height: 8.h,),
        CustomText(
          text: categoryTitle.isNotEmpty
              ? (categoryTitle.length > 13
              ? "${categoryTitle[0].toUpperCase()}${categoryTitle.substring(1, 10)}..."
              : "${categoryTitle[0].toUpperCase()}${categoryTitle.substring(1)}")
              : "",
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: AppColor.blackColor,
        ),
      ],
    );
  }
}
