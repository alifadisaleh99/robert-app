




import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/tests/state.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/screens/home/service/home_service.dart';

class TestsCubit extends Cubit<TestsState> {
  TestsCubit() : super(AppInitialState()){
    getTests();
  }


  static TestsCubit get(context) => BlocProvider.of(context);

  bool isLoadingTests = true;
  MostPopularModel testsModel = MostPopularModel();
  Future<void> getTests() async {
    isLoadingTests = true;
    emit(SliderLoadingState());
    Either<Object, MostPopularModel>? response = await HomeService().getTests();
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
}