import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/bottom_nav_cubit.dart/state.dart';
import 'package:robquiz/model/network/category_model.dart';
import '../../shared/network/local/cache_helper.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit(this.context, this.index,) : super(BottomNavInitialState()) {
    if(index!=null)
     changeIndex(
       index!,
       q ??"",
       categoryData,
     );
  }
  final int? index;
   CategoryData? categoryData;
   String? q  = "";
final BuildContext context;
  PageController? pageController = PageController();
  static BottomNavCubit get(context) => BlocProvider.of(context);

  DateTime? lastBackPressTime; 
  int currentIndex = 0;

  Future changeIndex(int index,String? search,CategoryData? categoryDataIndex) async{
    currentIndex =index;
    q = search;
    categoryData = categoryDataIndex ?? CategoryData();

    emit(AppChangeBottomNavBarState());
  }


}
