import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/model/network/slider_model.dart';
import 'package:robquiz/shared/customs/custom_button.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/image_assets.dart';

import '../../../shared/styles/color.dart';

class CustomSlider extends StatelessWidget {
  final List<SliderData>? data;
  final int colorBool;
  final CarouselSliderController? carouselController;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final void Function(SliderData)? onTap; // Updated to pass SliderData on tap

  const CustomSlider({
    super.key,
    this.data,
    this.carouselController,
    this.onPageChanged,
    required this.colorBool,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> photos = [
      "https://api.robquiz.com/storage/survey/surveys_17138683705085.png",
      "https://api.robquiz.com/storage/survey/surveys_17371403038743.jpg",
      "https://api.robquiz.com/storage/survey/surveys_17131749752630.webp",
    ];
    SliderModel sliderModel = SliderModel(
      data: photos.asMap().entries.map((entry) {
        int index = entry.key; // Use index for unique ID
        String url = entry.value;

        return SliderData(
          id: index + 1, // Unique ID
          media: Media(
            id: index + 1, // Unique ID for Media
            file: url,
          ),
          linkedType: null,
          linkedId: null,
          type: "image",
          externalLink: null,
        );
      }).toList(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        children: [
          CarouselSlider(
            items: sliderModel.data!
                .map(
                  (sliderData) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child:

                  CachedNetworkImage(
                    imageUrl: sliderData.media?.file ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 185.h,
                  ),
                ),
              ),
            )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              height: 190.h,
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 2.0,
              viewportFraction: 0.95,
              onPageChanged: onPageChanged,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 170.0.h),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                    sliderModel.data?.length ?? 0,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        height: 6.h,
                        width: (index == colorBool) ? 30.h : 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.h),
                          color: (index == colorBool)
                              ? AppColor.primary2Color
                              : AppColor.primary1Color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



