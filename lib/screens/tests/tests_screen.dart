import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/cubit/category/cubit.dart';
import 'package:robquiz/cubit/category/state.dart';
import 'package:robquiz/cubit/tests/cubit.dart';
import 'package:robquiz/cubit/tests/state.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/screens/home/widget/best_selling_card.dart';
import 'package:robquiz/screens/tests/filtter_screen.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/customs/empty_container.dart';
import 'package:robquiz/shared/customs/loading_top.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';
import 'package:robquiz/shared/styles/image_assets.dart';

class TestsScreen extends StatelessWidget {
  final CategoryData categoryData;
  final String? q ;
  const TestsScreen({super.key, required this.categoryData, this.q});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => TestsCubit(categoryData,q),
        child: BlocConsumer<TestsCubit, TestsState>(
            listener: (BuildContext context, TestsState state) {},
            builder: (BuildContext context, TestsState state) {
              TestsCubit cubit = TestsCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: LoadingManager(
                  isLoading: cubit.isLoadingTests,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text:  (q !=""&&  q !=null) ?  q ?? "" :(cubit.selectedBrandId!=null&&cubit.selectedBrandId!=0) ? cubit.nameCategory ?? "" : S.of(context).Alltests,
                              // text: "${S.of(context).Alltests}:",
                              color: AppColor.primary1Color,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: FiltterScreen(),
                          ),
                        ),
                      ).then((_) => {
                        cubit.getTests(
                      isFirst : false,
                         categoryId:(cubit.selectedBrandId !=0&&cubit.selectedBrandId !=null)? cubit.selectedBrandId:null,
                          q: "",
                        ),
                      });
                    },
                    child: Image.asset(
                      AppImageAsset.filtterIcon,
                      width: 22.h,
                      height: 22.h,
                    ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      if(cubit.testsModel.data?.length!=null&&cubit.testsModel.data?.length!=0)
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
                      if(cubit.testsModel.data?.length==null||cubit.testsModel.data?.length==0)
                        EmptyContainer(
                          titleEmpty: S.of(context).Notestsfound,
                          bodyEmpty: S.of(context).Sorrynotestsmatchthefiltercriteriayouapplied,
                        ),
                      SizedBox(height: 50,),

                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
