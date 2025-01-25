import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/cubit/category/cubit.dart';
import 'package:robquiz/cubit/category/state.dart';
import 'package:robquiz/cubit/tests/cubit.dart';
import 'package:robquiz/cubit/tests/state.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/screens/home/widget/best_selling_card.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/customs/loading_top.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => TestsCubit(),
        child: BlocConsumer<TestsCubit, TestsState>(
            listener: (BuildContext context, TestsState state) {},
            builder: (BuildContext context, TestsState state) {
              TestsCubit cubit = TestsCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: CustomText(
                        text: "${S.of(context).Alltests}:",
                        color: AppColor.primary1Color,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                    SizedBox(height: 30,),
                    LoadingManager(
                      isLoading: cubit.isLoadingTests,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.testsModel.data?.length  ?? 0,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.65,
                          ),
                          itemBuilder: (context, index) {

                            return BestSellingCard(

                                goToDetails: () {
                                },

                                image: "${Config.storageImage}/${cubit.testsModel.data?[index].image}",

                                price:"",

                                productName:"${cubit.testsModel.data?[index].arName}"
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),

                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
