import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/screens/test_details/test_details_screen.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
import 'package:robquiz/shared/styles/color.dart';
import 'package:robquiz/shared/styles/image_assets.dart';

class BestSellingCard extends StatelessWidget {
  final String image;


  final String productName;
  final String price;

  final void Function()? goToDetails;

  const BestSellingCard(
      {super.key, required this.image,  required this.productName, required this.price, this.goToDetails,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToDetails ,

      child: Container(
        width: 200.h,
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: CachedNetworkImageProvider(
              image,
          ),
          fit: BoxFit.cover
          ),
          border: Border.all(color: AppColor.borderInput, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              // Adjust shadow color transparency
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4), // Horizontal and vertical shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColor.primary1Color
              ),
             height: 60.h,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CustomText(
                  text:  productName,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

            ),


          ],
        ),
      ),
    );
  }
}
