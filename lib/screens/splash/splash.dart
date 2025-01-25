import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/styles/color.dart';

import '../../cubit/splash_cubit/splash_cubit.dart';
import '../../cubit/splash_cubit/splash_state.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/image_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return BlocProvider(
      create: (BuildContext context) => AppCubitSplash(context,),
      child: BlocConsumer<AppCubitSplash, AppStatesSplash>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubitSplash cubit = AppCubitSplash.get(context);

            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColor.primary1Color,

                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Rob',
                        color: AppColor.primary2Color,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: 'Quiz',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
