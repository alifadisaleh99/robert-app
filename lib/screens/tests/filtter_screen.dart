import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/cubit/tests/cubit.dart';
import 'package:robquiz/cubit/tests/state.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/shared/customs/custom_button.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/styles/color.dart';

class FiltterScreen extends StatelessWidget {
  const FiltterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<TestsCubit, TestsState>(
          listener: (BuildContext context, TestsState state) {},
          builder: (BuildContext context, TestsState state) {
            TestsCubit cubit = TestsCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Row(
                      children: [
                        Container(
                          width: 40.h,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.h),
                            border: Border.all(
                              color: AppColor.borderButton, // Border color
                              width: 1, // Border width (1px)
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: S.of(context).Filter,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.categoryModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final CategoryData brand =
                        cubit.categoryModel.data![index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "${brand.name}",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.blackColor,
                            ),
                            Radio<int>(
                              activeColor: AppColor.blueColor, // Selected color
                              value: brand.id ?? 0,
                              groupValue: cubit.selectedBrandId,
                              onChanged: (value) {
                                cubit.updateSelectedBrand(value ?? 0,brand.name??"");
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: S.of(context).Apply,
                      borderRadius: 10,
                      paddingVertical: 5,
                      paddingHorizontal: 5,
                      colorText: AppColor.yellowColor,
                      colorBorder: AppColor.blueColor,
                      colorBackGround: AppColor.blueColor,
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: S.of(context).Reset,
                      borderRadius: 10,
                      paddingVertical: 5,
                      paddingHorizontal: 5,
                      colorText: AppColor.blackColor,
                      colorBorder: Colors.white,
                      colorBackGround: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        cubit.resetSelection();
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
