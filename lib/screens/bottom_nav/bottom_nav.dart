import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:robquiz/cubit/bottom_nav_cubit.dart/bottom_nav_cubit.dart';
import 'package:robquiz/cubit/bottom_nav_cubit.dart/state.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/screens/categories/categories_screen.dart';
import 'package:robquiz/screens/home/home_screen.dart';
import 'package:robquiz/screens/tests/tests_screen.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/color.dart';
import '../../shared/styles/image_assets.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  final int? index;
  const BottomNavigationBarScreen({super.key, this.index=0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BottomNavCubit(context,index),
      child: BlocConsumer<BottomNavCubit, BottomNavStates>(
        listener: (BuildContext context, BottomNavStates state) {},
        builder: (BuildContext context, BottomNavStates state) {
          BottomNavCubit cubit = BottomNavCubit.get(context);



          List<BottomNavigationBarItem> bottomItems = [
            BottomNavigationBarItem(
              icon:  cubit.currentIndex == 0 ? Icon(
                Icons.home,
                color: AppColor.primary1Color,
                size: 20,
              ): Icon(
                Icons.home_outlined,
                color: AppColor.blackColor,
                size: 20,
              ),

              label: S.of(context).Home,
            ),
            BottomNavigationBarItem(
              icon:  cubit.currentIndex == 1 ? Icon(
                Icons.library_books,
                color: AppColor.primary1Color,
                size: 20,
              ): Icon(
                Icons.library_books_outlined,
                color: AppColor.blackColor,
                size: 20,
              ),

              label: S.of(context).Tests,
            ),
            BottomNavigationBarItem(
              icon:  cubit.currentIndex == 2 ? Icon(
                Icons.category,
                color: AppColor.primary1Color,
                size: 20,
              ): Icon(
                Icons.category_outlined,
                color: AppColor.blackColor,
                size: 20,
              ),
              label:
              S.of(context).Categories,
            ),
          ];
          List<Widget> screens = [
            const HomeScreen(),
             const TestsScreen(),
            const CategoriesScreen(),

          ];
          return WillPopScope(
            onWillPop: () async {
              if (cubit.currentIndex != 0) {
                cubit.changeIndex(0);
                return false;
              } else {
                DateTime now = DateTime.now();
                if (cubit.lastBackPressTime == null || now.difference(cubit.lastBackPressTime!) > const Duration(seconds: 2)) {
                  cubit.lastBackPressTime = now;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColor.blueColor,
                      content: CustomText(
                        text: S.of(context).Pressbackagaintoexittheapp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return false;
                }
                return true; // Exit the app
              }
            },
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print("FAB Pressed!");
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: AppColor.primary1Color,
                  size: 28,
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              body: screens[cubit.currentIndex],
              bottomNavigationBar: Container(
                height:  75.h,
                decoration:  BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                    color: Color(0x26979797), // #979797 with 15% opacity
                offset: Offset(0, 0), // X and Y offset
                blurRadius: 8, // Blur radius
                spreadRadius: 0, // Spread radius
              ),
                ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: BottomNavigationBar(
                  unselectedItemColor:  AppColor.blackColor,
                  selectedItemColor: AppColor.primary1Color,
                  unselectedLabelStyle:  TextStyle(
                    color: AppColor.blackColor,
                    fontSize:  12,
                    fontWeight: FontWeight.w500,
                    fontFamily:  CacheHelper.getData(key: 'locale') == "ar"? "Almarai" :"Inter",
            
                  ),
                  selectedLabelStyle:  TextStyle(
                    color:AppColor.primary1Color,
                    fontSize:  12,
                    fontWeight: FontWeight.w500,
                      fontFamily:  CacheHelper.getData(key: 'locale') == "ar"? "Almarai" :"Inter",
                  ),
                  mouseCursor: MouseCursor.uncontrolled,
                  landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                  enableFeedback: false,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeIndex(
                      index,
                    );
                  },
                  items: bottomItems,
                ),),
            ),
          );
        },
      ),
    );
  }
}
