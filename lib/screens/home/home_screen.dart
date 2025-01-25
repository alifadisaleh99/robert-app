import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/cubit/bottom_nav_cubit.dart/bottom_nav_cubit.dart';
import 'package:robquiz/cubit/home/cubit.dart';
import 'package:robquiz/cubit/home/state.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/model/network/slider_model.dart';
import 'package:robquiz/screens/home/widget/best_selling_card.dart';
import 'package:robquiz/screens/home/widget/custom_search_feild.dart';
import 'package:robquiz/screens/home/widget/custom_slider.dart';
import 'package:robquiz/screens/home/widget/row_see_all.dart';
import 'package:robquiz/shared/customs/loading_top.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/image_assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => HomeCubit(),
          child: BlocConsumer<HomeCubit, HomeState>(
              listener: (BuildContext context, HomeState state) {},
              builder: (BuildContext context, HomeState state) {
                HomeCubit cubit = HomeCubit.get(context);
                BottomNavCubit bottomNavCubit = BottomNavCubit.get(context);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomSearchFeild(
                          controller: cubit.controllerSearch,
                          onPressedIcon: (){
                          },
                          onChanged: (value){
                          },

                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      LoadingManager(
                        isLoading: cubit.isLoadingCategory||cubit.isLoadingMostPopular,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSlider(
                              onTap: (SliderData sliderData) {
                                if (sliderData.type == null) {
                                } else if (sliderData.type == 'external_link') {
                                  cubit.launchURL(url: sliderData.externalLink ?? "");
                                } else if (sliderData.type == 'internal_linked') {
                                  switch (sliderData.linkedType) {
                                    case 'brand':
                                      break;
                                    case 'product':
                                      break;
                                    case 'category':
                                      break;
                                    case 'subcategory':

                                      break;
                                    default:
                                      break;
                                  }
                                }
                              },
                              colorBool: cubit.current,
                              carouselController: cubit.controller,
                              data:  [],
                              onPageChanged: (index, reason) {
                                cubit.onIndexAdChanged(index);
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            RowSeeAll(
                                title: "${S.of(context).LatestTests}",
                                onTap  :(){
                                  bottomNavCubit.changeIndex(1);
                                }

                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              height: 322.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                cubit.newestModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: index == 0 ? 20 : 15,
                                      ),
                                      BestSellingCard(

                                        goToDetails: () {
                                        },

                                        image: "${Config.storageImage}/${cubit.newestModel.data?[index].image}",

                                        price:"",

                                        productName:"${cubit.newestModel.data?[index].arName}"
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: GestureDetector(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child:
                                    // Image.asset(AppImageAsset.app,
                                    //   width: double.infinity,
                                    //     height: 150.h,),
                                    Image.network(
                                      "https://api.robquiz.com/storage/survey/surveys_17138683705085.png",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 175.h,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: 20.h,
                            ),
                            RowSeeAll(
                                title: "${S.of(context).Mostpopulartests}",
                                onTap  :(){
                                  bottomNavCubit.changeIndex(1);
                                }

                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              height: 322.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                cubit.mostPopularModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: index == 0 ? 20 : 15,
                                      ),
                                      BestSellingCard(

                                          goToDetails: () {
                                          },

                                          image: "${Config.storageImage}/${cubit.mostPopularModel.data?[index].image}",

                                          price:"",

                                          productName:"${cubit.mostPopularModel.data?[index].arName}"
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            RowSeeAll(
                                title: "${S.of(context).Randomtests}",
                                onTap  :(){
                                  bottomNavCubit.changeIndex(1);
                                }

                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              height: 322.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                cubit.featuredModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: index == 0 ? 20 : 15,
                                      ),
                                      BestSellingCard(

                                          goToDetails: () {
                                          },

                                          image: "${Config.storageImage}/${cubit.featuredModel.data?[index].image}",

                                          price:"",

                                          productName:"${cubit.featuredModel.data?[index].arName}"
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            RowSeeAll(
                                title: "${S.of(context).Categories}",
                                onTap  :(){
                                  bottomNavCubit.changeIndex(2);
                                }

                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              height: 322.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                cubit.categoryModel.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: index == 0 ? 20 : 15,
                                      ),
                                      BestSellingCard(

                                          goToDetails: () {
                                          },

                                          image: "${Config.storageImage}/${cubit.categoryModel.data?[index].image}",

                                          price:"",

                                          productName:"${cubit.categoryModel.data?[index].name}"
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
