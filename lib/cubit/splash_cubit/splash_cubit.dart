import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/splash_cubit/splash_state.dart';
import 'package:robquiz/screens/bottom_nav/bottom_nav.dart';
import 'package:robquiz/shared/customs/nav_and_finish.dart';
import '../../shared/network/local/cache_helper.dart';

class AppCubitSplash extends Cubit<AppStatesSplash> {
  AppCubitSplash(this.context, ) : super(AppInitialState()) {
    onReady(context);
  }





  static AppCubitSplash get(context) => BlocProvider.of(context);
  final BuildContext context;
  void onReady(BuildContext context) {
    _startTimer(context);
  }
  int _seconds = 0;
  void _startTimer(BuildContext context) {
    Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      _seconds += 1;
      if (_seconds == 3) {
        timer.cancel();
        navigateAndFinish(
          context,
          const BottomNavigationBarScreen(),
        );

      }
    });
  }
}
