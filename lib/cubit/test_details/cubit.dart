




import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/test_details/state.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/screens/home/service/home_service.dart';
import 'package:robquiz/screens/test_details/service/test_service.dart';

class TestsDetailsCubit extends Cubit<TestsDetailsState> {
  TestsDetailsCubit(this.test) : super(AppInitialState()){
    getTestDetails(slug: test.slug??"").then((_)=>{
      testType = test.surveyType??"",
      if(testChoosesTimeModel.survey?.length!=null&&testChoosesTimeModel.survey?.length!=0){
        getTestLikeModel(categoryId: testChoosesTimeModel.survey?[0].categoryId,targetId: testChoosesTimeModel.survey?[0].id),

      }
    });

  }
  final MostPopularData  test;
String testType = "";
  bool isLoadingTest = true;
  TestChoosesTimeModel testChoosesTimeModel = TestChoosesTimeModel();
  Future<void> getTestDetails({required String slug}) async {
    isLoadingTest = true;
    emit(CategoriesGetLoadingState());
    Either<Object, TestChoosesTimeModel>? response = await TestsService().getTestDetails(slug: slug);
    response.fold((l) {
      isLoadingTest = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      testChoosesTimeModel = r;
      isLoadingTest = false;
      emit(CategoriesGetSuccessState());
    });
    isLoadingTest = false;
  }


  static TestsDetailsCubit get(context) => BlocProvider.of(context);

  Map<int, bool> isQuestionAnswer = {};

  void setIndexQuestionInList({required int index, required bool isCorrect}) {
    isQuestionAnswer[index] = isCorrect;
    print("787878787889798987");
    print(isQuestionAnswer.values.where((value) => value).length);
    print(testChoosesTimeModel.surveyDetails?.length);
    if(isQuestionAnswer.keys.length==testChoosesTimeModel.surveyDetails?.length){
      endTest();

    }
    emit(ToggleAddQuestionToList());
  }
  String getFeedbackMessage(int percent) {
    if (percent >= 0 && percent <= 20) {
      return "لا تقلق، العبها مرة أخرى وستصبح محترفًا! إذا لم تفشل، فلن تتعلم.";
    } else if (percent >= 21 && percent <= 50) {
      return "أنت في منتصف الطريق، استمر! القادم سيكون أسهل.";
    } else if (percent >= 51 && percent <= 80) {
      return "أداء رائع! فقط بعض الإجابات القليلة تفصلك عن الصدارة.";
    } else if (percent >= 81 && percent <= 99) {
      return "أداء مبهر! فقط خطوة صغيرة نحو الصدارة الكاملة.";
    } else if (percent == 100) {
      return "عبقري! لقد أظهرت للجميع من هو السيد هنا!";
    } else {
      return "";
    }
  }

  bool isLoadingTestLike = true;
  MostPopularModel testLikeModel = MostPopularModel();
  Future<void> getTestLikeModel({ int? targetId , int? categoryId}) async {
    isLoadingTestLike = true;
    emit(CategoriesGetLoadingState());
    Either<Object, MostPopularModel>? response = await TestsService().getTestsLike(categoryId: categoryId,targetId:targetId );
    response.fold((l) {
      isLoadingTestLike = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      testLikeModel = r;
      isLoadingTestLike = false;
      emit(CategoriesGetSuccessState());
    });
    isLoadingTestLike = false;
  }



  bool isStartTest=false;

  bool isStopTest=false;

  int remainingTime = 300; // 5 minutes in seconds
  Timer? timer;

  void startTest() {
    isQuestionAnswer={};
    isStopTest=false;
    isStartTest = true;
      remainingTime = 300;
      emit(SetTimerState());


    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (remainingTime > 0) {
          remainingTime--;
          emit(SetTimerState());
      } else {
        endTest();
      }
    });
      emit(SetTimerState());

  }
  void endTest() {

    for (int index = 0; index < testChoosesTimeModel.surveyDetails!.length; index++) {
      if (!isQuestionAnswer.containsKey(index)) {
        setIndexQuestionInList(index: index, isCorrect: false);
      }
    }
    isStopTest = true;

    isStartTest = false;
    remainingTime = 300; // Reset timer
    timer?.cancel();
    emit(SetTimerState());

  }
  void stopTest() {
    isQuestionAnswer={};
    isStopTest=false;
    isStartTest = false;
      remainingTime = 300; // Reset timer
      timer?.cancel();
      emit(SetTimerState());
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    return "$minutes:${sec.toString().padLeft(2, '0')}";
  }

  @override
  Future<void> close() {
    stopTest();
    return super.close();
  }

}