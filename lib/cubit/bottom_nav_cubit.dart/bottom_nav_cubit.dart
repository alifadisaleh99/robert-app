import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:robquiz/cubit/bottom_nav_cubit.dart/state.dart';
import '../../shared/network/local/cache_helper.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit(this.context, this.index) : super(BottomNavInitialState()) {
    if(index!=null)
     changeIndex(
       index!
     );
  }
  final int? index;

final BuildContext context;
  PageController? pageController = PageController();
  static BottomNavCubit get(context) => BlocProvider.of(context);

  DateTime? lastBackPressTime; 
  int currentIndex = 0;

  void changeIndex(int index,) {
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }


}
