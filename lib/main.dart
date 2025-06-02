import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/cubit/bloc_observer.dart';
import 'package:robquiz/cubit/bottom_nav_cubit.dart/bottom_nav_cubit.dart';
import 'package:robquiz/cubit/test_details/cubit.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/screens/bottom_nav/bottom_nav.dart';
import 'package:robquiz/screens/splash/splash.dart';
import 'package:robquiz/shared/locale/locale_cubit.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
import 'package:robquiz/shared/network/remote/dio_helper.dart';
import 'package:robquiz/shared/styles/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (BuildContext context) => LocaleCubit()),
        BlocProvider<BottomNavCubit>(create: (BuildContext context) => BottomNavCubit(context,0)),
        BlocProvider<TestsDetailsCubit>(create: (BuildContext context) => TestsDetailsCubit(MostPopularData())),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          DioHelper.init();
          return ScreenUtilInit(
            designSize: const Size(430, 932),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return
                MaterialApp(
                  themeMode: ThemeMode.light,
                  color: AppColor.blueColor,
                  theme: ThemeComponent.getTheme(),
                  locale:
                  // CacheHelper.getData(key: 'locale') != null
                  //     ? Locale(CacheHelper.getData(key: 'locale'))
                  //     :
                  Locale('ar'),
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    for (var locale in supportedLocales) {
                      if (deviceLocale != null &&
                          deviceLocale.languageCode == locale.languageCode) {
                        return deviceLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  home:  SplashScreen(),
                  debugShowCheckedModeBanner: false,
                  title: 'RobQuiz',
                );
            },
          );
        },
      ),
    );
  }

}


