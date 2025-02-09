import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/category/state.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/model/network/slider_model.dart';
import 'package:robquiz/screens/home/service/home_service.dart';
import 'package:url_launcher/url_launcher.dart';


class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(AppInitialState()){
    getCategory();
  }
  static CategoryCubit get(context) => BlocProvider.of(context);


  bool isLoadingCategory = true;
  CategoryModel categoryModel = CategoryModel();
  Future<void> getCategory() async {
    isLoadingCategory = true;
    emit(CategoriesGetLoadingState());
    Either<Object, CategoryModel>? response = await HomeService().getCategory();
    response.fold((l) {
      isLoadingCategory = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      categoryModel = r;
      isLoadingCategory = false;
      emit(CategoriesGetSuccessState());
    });
    isLoadingCategory = false;
  }


}


