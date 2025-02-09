




import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/tests/state.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/screens/home/service/home_service.dart';

class TestsCubit extends Cubit<TestsState> {
  TestsCubit(this.categoryData, this.q) : super(AppInitialState()){
    selectedBrandId = categoryData.id??0;
    nameCategory = categoryData.name ?? "";
    getCategory();
    getTests(q: q,categoryId: categoryData.id,isFirst: true);

  }

  final CategoryData categoryData;
  final String? q ;
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


  static TestsCubit get(context) => BlocProvider.of(context);

  bool isLoadingTests = true;
  MostPopularModel testsModel = MostPopularModel();
  Future<void> getTests({String? q , int? categoryId,required bool isFirst }) async {
    if(isFirst)
      isLoadingTests = true;
    emit(SliderLoadingState());
    Either<Object, MostPopularModel>? response = await HomeService().getTests(
      q:q ,
      categoryId: categoryId,
    );
    response.fold((l) {
      isLoadingTests = false;
      emit(SliderErrorState());
    }, (r) {
      testsModel = r;
      isLoadingTests = false;
      emit(SliderSuccessState());
    });
    isLoadingTests = false;
  }

  int? selectedBrandId;
String nameCategory = "";
  void updateSelectedBrand(int brandId,String name) {
    selectedBrandId = brandId;
    nameCategory = name;
    emit(ToggleSelectAllState());
  }

  void resetSelection() {
    selectedBrandId = null;
    emit(ToggleSelectAllState());
  }

}