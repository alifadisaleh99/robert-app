


import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/home/state.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/model/network/slider_model.dart';
import 'package:robquiz/screens/home/service/home_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(AppInitialState()){
    getMostPopular();
    getCategory();
    getNewest();
    getFeatured();
  }
  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController? controllerSearch = TextEditingController();

  List<String> photos = ["https://via.placeholder.com/390x172","https://via.placeholder.com/390x172","https://via.placeholder.com/390x172",];
  final CarouselSliderController controller = CarouselSliderController();
  TextEditingController codeController =TextEditingController();
  int current = 0;


  onIndexAdChanged(int index) {
    current = index;
    emit(ChangedAdSliderState());
  }
  List<Widget> imageSliders = [];
  // voidSlider(){
  //
  //   for (int i = 0; i < photos!.length; i++) {
  //
  //     imageSliders.add(
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: Container(
  //
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                   image: CachedNetworkImageProvider(
  //                     "${Config.baseURL}/${photos[i]}" ?? "",
  //
  //                   ),
  //                   fit: BoxFit.fill),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  final List<Map<String, String>> brandList = [
    {"image": "http://via.placeholder.com/50x50", "brandTitle": "Brand Title 1"},
    {"image": "http://via.placeholder.com/50x50", "brandTitle": "Brand Title 2"},
    {"image": "http://via.placeholder.com/50x50", "brandTitle": "Brand Title 3"},
    {"image": "http://via.placeholder.com/50x50", "brandTitle": "Brand Title 4"},
  ];





  void launchURL({required String url} ) async {
    final urlFinal = Uri.parse(url);
    if (await canLaunchUrl(urlFinal)) {
      await launchUrl(urlFinal, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool isLoadProduct =false;



  int? isLoadingAtIndex =0;

List adsModel = [];

  bool isLoadingMostPopular = true;
  MostPopularModel mostPopularModel = MostPopularModel();
  Future<void> getMostPopular() async {
    isLoadingMostPopular = true;
    emit(CategoriesGetLoadingState());
    Either<Object, MostPopularModel>? response = await HomeService().getMostPopular();
    response.fold((l) {
      isLoadingMostPopular = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      mostPopularModel = r;
      isLoadingMostPopular = false;
      emit(NewArriveGetSuccessState());
    });
    isLoadingMostPopular = false;
  }



  bool isLoadingFeatured = true;
  MostPopularModel featuredModel = MostPopularModel();
  Future<void> getFeatured() async {
    isLoadingFeatured = true;
    emit(CategoriesGetLoadingState());
    Either<Object, MostPopularModel>? response = await HomeService().getFeatured();
    response.fold((l) {
      isLoadingFeatured = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      featuredModel = r;
      isLoadingFeatured = false;
      emit(NewArriveGetSuccessState());
    });
    isLoadingFeatured = false;
  }




  bool isLoadingNewest = true;
  MostPopularModel newestModel = MostPopularModel();
  Future<void> getNewest() async {
    isLoadingNewest = true;
    emit(CategoriesGetLoadingState());
    Either<Object, MostPopularModel>? response = await HomeService().getNewest();
    response.fold((l) {
      isLoadingNewest = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      newestModel = r;
      isLoadingNewest = false;
      emit(NewArriveGetSuccessState());
    });
    isLoadingNewest = false;
  }



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
      emit(NewArriveGetSuccessState());
    });
    isLoadingCategory = false;
  }




}


