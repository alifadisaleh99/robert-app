




// import 'dart:async';

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robquiz/cubit/test_details/state.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/screens/home/service/home_service.dart';
import 'package:robquiz/screens/test_details/service/test_service.dart';

import '../../model/network/test_details_input_model.dart';

class TestsDetailsCubit extends Cubit<TestsDetailsState> {
  TestsDetailsCubit(this.test) : super(AppInitialState()){

    if(test.surveyType=="sudden_death"){

      getTestDetailsSuddenDeath(slug: test.slug??"").then((_)=>{
        if(testChoosesTimeSuddenModel.survey?.length!=null&&testChoosesTimeSuddenModel.survey?.length!=0){
          testType = testChoosesTimeSuddenModel.survey?[0].surveyType??"",
          if(testChoosesTimeSuddenModel.survey![0].timer!=null){
            remainingTime.value = testChoosesTimeSuddenModel.survey![0].timer! * 60 ?? 300,


          }else{
            remainingTime.value = 300 ,
          },
        }else{
          testType = test.surveyType??"",
        },
        if(testChoosesTimeSuddenModel.survey?.length!=null&&testChoosesTimeSuddenModel.survey?.length!=0){
          getTestLikeModel(categoryId: testChoosesTimeSuddenModel.survey?[0].categoryId,targetId: testChoosesTimeSuddenModel.survey?[0].id),
        },
      formatTime(remainingTime.value),

      });
    }else{
      getTestDetails(slug: test.slug??"").then((_)=>{
        if(testChoosesTimeModel.survey?.length!=null&&testChoosesTimeModel.survey?.length!=0){
          testType = testChoosesTimeModel.survey?[0].surveyType??"",
          if(testChoosesTimeModel.survey![0].timer!=null){
            remainingTime.value = testChoosesTimeModel.survey![0].timer! * 60 ?? 300,

          }else{
            remainingTime.value = 300 ,
          },

        }else{
          testType = test.surveyType??"",
        },
        if(testChoosesTimeModel.survey?.length!=null&&testChoosesTimeModel.survey?.length!=0){
          getTestLikeModel(categoryId: testChoosesTimeModel.survey?[0].categoryId,targetId: testChoosesTimeModel.survey?[0].id),

        },
        formatTime(remainingTime.value),
      });
    }






  }



  TextEditingController inputText = TextEditingController();
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
      if(testChoosesTimeModel.survey?.length!=null&&testChoosesTimeModel.survey?.length!=0){
      if(testChoosesTimeModel.survey?[0].surveyType=="top_ten"){
        populateAnswersInput();
      }
      }
      isLoadingTest = false;
      emit(CategoriesGetSuccessState());
    });
    isLoadingTest = false;
  }


  bool isLoadingSuddenTest = true;
  TestDetailsSuddenDeathModel testChoosesTimeSuddenModel = TestDetailsSuddenDeathModel();
  Future<void> getTestDetailsSuddenDeath({required String slug}) async {
    isLoadingTest = true;
    emit(CategoriesGetLoadingState());
    Either<Object, TestDetailsSuddenDeathModel>? response = await TestsService().getTestDetailsSuddenDeath(slug: slug);
    response.fold((l) {
      isLoadingTest = false;
      emit(CategoriesGetErrorState());
    }, (r) {
      testChoosesTimeSuddenModel = r;
      isLoadingTest = false;
      emit(CategoriesGetSuccessState());
    });
    isLoadingTest = false;
  }

  List<String> answersInput =[];
  void populateAnswersInput() {
    answersInput.clear(); // Clear existing data to avoid duplicates
    if (testChoosesTimeModel.surveyDetails != null) {
      for (SurveyChoosesTimeDetail detail in testChoosesTimeModel.surveyDetails!) {
        if (detail.question != null && detail.question!.answers != null) {
          String answer = detail.question!.answers!.first ?? "";

          // Only add non-empty answers
          if (answer.trim().isNotEmpty) {
            answersInput.add(answer);
          }
        }
      }
    }
  }
  Map<int, String> inputMapAnswers = {};
  Future setInputAnswers({required int index, required String answer})async{
    inputMapAnswers[index] = answer;
    if(inputMapAnswers.keys.length+1 == testChoosesTimeModel.surveyDetails?.length){
      endTest();
    }
    inputText.text = "";
    emit(ToggleAddQuestionToList());
  }

  static TestsDetailsCubit get(context) => BlocProvider.of(context);

  Map<int, bool> isQuestionAnswer = {};
  List<String> listDeath = [];

  bool isEnding = false;

  Future<void> setIndexQuestionInList({required int index, required bool isCorrect,}) async{
    // if (isEnding) return; // Prevent recursive calls
    isQuestionAnswer[index] = isCorrect;

    if (test.surveyType == "sudden_death") {
      if (isQuestionAnswer.keys.length == testChoosesTimeSuddenModel.surveyDetails?[0].question?.arOptions?.length) {
        endTest();
      }
    } else {
      if (isQuestionAnswer.keys.length == testChoosesTimeModel.surveyDetails?.length) {
        endTest();
      }
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

  bool isLoadingTestLike = false;
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
      emit(LikeGetSuccessState());
    });
    isLoadingTestLike = false;
  }



  bool isStartTest=false;

  bool isStopTest=false;

  ValueNotifier<int> remainingTime = ValueNotifier<int>(300);
  Timer? timer;
  bool isTimerRunning = false;

  Future<void> startTest() async {

    // Stop any existing timer
    stopTimerSafely();

    // Reset variables
    listDeath = [];
    answersInputUnCorrect = [];
    inputMapAnswers = {};
    isQuestionAnswer = {};
    isStopTest = false;
    isStartTest = true;
    isTimerRunning = true;

    // Set timer duration safely
    try {
      if (testType == "sudden_death" &&
          testChoosesTimeSuddenModel.survey != null &&
          testChoosesTimeSuddenModel.survey!.isNotEmpty) {
        remainingTime.value = testChoosesTimeSuddenModel.survey![0].timer != null
            ? testChoosesTimeSuddenModel.survey![0].timer! * 60
            : 300;
      } else if (testChoosesTimeModel.survey != null &&
          testChoosesTimeModel.survey!.isNotEmpty) {
        remainingTime.value = testChoosesTimeModel.survey![0].timer != null
            ? testChoosesTimeModel.survey![0].timer! * 60
            : 300;
      }
    } catch (e) {
      print("Error setting timer: $e");
      remainingTime.value = 300; // Fallback
    }

    // // Use a standard Timer instead of Future.delayed loop
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   if (isClosed || isStopTest || !isTimerRunning) {
    //     stopTimerSafely();
    //     return;
    //   }
    //
    //   if (remainingTime.value > 0) {
    //     remainingTime.value--;
    //     formatTime(remainingTime.value);
    //
    //     if (!isClosed) {
    //       emit(SetTimerState());
    //     }
    //   } else {
    //     stopTimerSafely();
    //     // Use Future.microtask to avoid potential issues
    //     Future.microtask(() => endTest());
    //   }
    // });

    // Initial state emission
    if (!isClosed) {
      emit(SetTimerState());
    }
  }

  void stopTimerSafely() {
    isTimerRunning = false;

    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  List<String> answersInputUnCorrect =[];
  Future<void> endTest() async{
    // if (isEnding) return; // Prevent multiple calls

    isEnding = true;

    if (testType == "normal") {
      for (int index = 0; index < testChoosesTimeModel.surveyDetails!.length; index++) {
        if (!isQuestionAnswer.containsKey(index)) {
          isQuestionAnswer[index] = false;

        }
      }
    } else if (testType == "top_ten") {
      for (int index = 1; index < testChoosesTimeModel.surveyDetails!.length; index++) {
        if (!inputMapAnswers.containsKey(index)) {
          answersInputUnCorrect.add(
              testChoosesTimeModel.surveyDetails?[index].question?.answers?.first ?? "");
          inputMapAnswers[index] = testChoosesTimeModel.surveyDetails?[index].question?.answers?.first ?? "";
        }
      }
    } else if (testType == "sudden_death") {
      for (int index = 1; index < testChoosesTimeSuddenModel.surveyDetails![0].question!.arOptions!.length; index++) {
        if (!inputMapAnswers.containsKey(index)) {
          answersInputUnCorrect.add(testChoosesTimeSuddenModel.surveyDetails![0].question!.arOptions?[index] ?? "");
          inputMapAnswers[index] = testChoosesTimeSuddenModel.surveyDetails![0].question!.answers?[index] ?? "false";
        }
      }
    }

    isStopTest = true;
    isStartTest = false;

    if (testType == "sudden_death") {
      remainingTime.value = (testChoosesTimeSuddenModel.survey![0].timer ?? 5) * 60;
    } else {
      remainingTime.value = (testChoosesTimeModel.survey![0].timer ?? 5) * 60;
    }
    formatTime(remainingTime.value);
    timer?.cancel();
    emit(SetTimerState());

    isEnding = false; // Reset the flag after completion
  }
  void stopTest() {
    if(testType=="sudden_death"){
      // isQuestionAnswer={};
    }else{
      isQuestionAnswer={};
    }

    isStopTest=false;
    isStartTest = false;
    if(testType=="sudden_death"){
      if(testChoosesTimeSuddenModel.survey![0].timer!=null){
        remainingTime.value = testChoosesTimeSuddenModel.survey![0].timer! * 60 ;
      }else{
        remainingTime.value = 300 ;
      };
    }else{
      if(testChoosesTimeModel.survey![0].timer!=null){
        remainingTime.value = testChoosesTimeModel.survey![0].timer! * 60 ;
      }else{
        remainingTime.value = 300 ;
      };
    }
    formatTime(remainingTime.value);
      timer?.cancel();
      emit(SetTimerState());
  }
  String timerSecond="";
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    timerSecond = "$minutes:${sec.toString().padLeft(2, '0')}";
    return timerSecond;
  }

  @override
  Future<void> close() {
    stopTimerSafely();
    // Also dispose ValueNotifier
    remainingTime.dispose();
    return super.close();
  }

  // Helper method to safely stop the timer


}