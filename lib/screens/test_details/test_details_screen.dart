import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:robquiz/cubit/test_details/cubit.dart';
import 'package:robquiz/cubit/test_details/state.dart';
import 'package:robquiz/generated/l10n.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/model/network/test_details_input_model.dart';
import 'package:robquiz/screens/home/widget/best_selling_card.dart';
import 'package:robquiz/screens/home/widget/row_see_all.dart';
import 'package:robquiz/screens/test_details/widget/custom_test_form.dart';
import 'package:robquiz/screens/test_details/widget/input_table_widget.dart';
import 'package:robquiz/screens/test_details/widget/normal_text_widget.dart';
import 'package:robquiz/screens/test_details/widget/rotate_image_widget.dart';
import 'package:robquiz/screens/test_details/widget/sudden_death_widget.dart';
import 'package:robquiz/shared/customs/custom_TextFormField.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/customs/loading_top.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';


//sudden_death
// puzzle

class TestDetailsScreen extends StatefulWidget {
  final MostPopularData test;

  const TestDetailsScreen({super.key, required this.test});

  @override
  State<TestDetailsScreen> createState() => _TestDetailsScreenState();
}

class _TestDetailsScreenState extends State<TestDetailsScreen> {
  Timer? _timer;
  int _remainingTime = 300; // Initial time in seconds (5 minutes)
  bool _isTestStarted = false;

  @override
  void initState() {
    super.initState();
  }

  // Start or stop the timer based on test state
  void _toggleTest() {
    setState(() {
      _isTestStarted = !_isTestStarted;
    });

    if (_isTestStarted) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  // Start the timer
  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _stopTimer(); // Stop when timer reaches 0
      }
    });
  }

  // Stop the timer
  void _stopTimer() {
    _timer?.cancel();
  }

  // Format the remaining time as minutes:seconds
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel(); // Ensure to cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestsDetailsCubit(widget.test),
      child: BlocConsumer<TestsDetailsCubit, TestsDetailsState>(
          listener: (BuildContext context, TestsDetailsState state) {},
          builder: (BuildContext context, TestsDetailsState state) {
            TestsDetailsCubit cubit = TestsDetailsCubit.get(context);

            return Scaffold(
              body:  Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: cubit.testType == "top_ten" ? 100.h: 50.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.27,
                                height: MediaQuery.of(context).size.width*0.27,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        "${Config.storageImage}/${widget.test.image}",
                                      ),
                                      ),
                                  border: Border.all(
                                      color: AppColor.borderInput, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.2),
                                      // Adjust shadow color transparency
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0,
                                          4), // Horizontal and vertical shadow position
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:(widget.test.notes!=""&&widget.test.notes!=null)? MainAxisAlignment.start:MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width*0.58,
                                    child: CustomText(
                                      text: widget.test.arName ?? "",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  if(widget.test.notes!=""&&widget.test.notes!=null)
                                    SizedBox(
                                    width: MediaQuery.of(context).size.width*0.58,
                                    height: MediaQuery.of(context).size.width*0.27-40,
                                    child: CustomText(
                                      text: widget.test.notes ?? "",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          if(cubit.testType == "top_ten")
                            Visibility(
                              visible: cubit.isStartTest ||cubit.isStopTest,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if(cubit.isStopTest)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),

                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                            width: MediaQuery.of(context).size.width*0.7,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.3),
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20.sp,
                                                text: "${(cubit.testChoosesTimeModel.surveyDetails!.length-1-cubit.answersInputUnCorrect.length)}/${cubit.testChoosesTimeModel.surveyDetails!.length-1}",
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  InputTableWidget(
                                    unCorrectAnswers: cubit.answersInputUnCorrect,
                                    surveyDetails: cubit.testChoosesTimeModel.surveyDetails ?? [],
                                   inputMapAnswers: cubit.inputMapAnswers,
                                  ),
                                  if (cubit.isStopTest)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            double percentValue = cubit.answersInputUnCorrect.length.toDouble() /
                                                (cubit.testChoosesTimeModel.surveyDetails!.length - 1).toDouble();

                                            // Ensure percent is between 0.0 and 1.0
                                            percentValue =(1-percentValue).toDouble();

                                            print("Incorrect Answers: ${cubit.answersInputUnCorrect.length}");
                                            print("Total Questions: ${cubit.testChoosesTimeModel.surveyDetails!.length}");
                                            print("Calculated Percent: $percentValue");

                                            return CircularPercentIndicator(
                                              radius: 60.0,
                                              lineWidth: 5.0,
                                              percent: percentValue,
                                              center: Text(
                                                "${(percentValue * 100).round()}%",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              progressColor: Colors.green,
                                            );
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: CustomText(
                                            text: cubit.getFeedbackMessage(
                                              (1-(cubit.answersInputUnCorrect.length.toDouble() /
                                                  (cubit.testChoosesTimeModel.surveyDetails!.length - 1).toDouble())).round(),
                                            ),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          if(cubit.testType == "normal")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(cubit.isStopTest)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),

                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                                        width: MediaQuery.of(context).size.width*0.7,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.sp,
                                            text: "${cubit.isQuestionAnswer.values.where((value) => value).length}/${cubit.testChoosesTimeModel.surveyDetails?.length}",
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              if(cubit.testChoosesTimeModel.surveyDetails?[0].question?.type=="text")
                                Visibility(
                                  visible: cubit.isStartTest ||cubit.isStopTest,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: cubit.testChoosesTimeModel.surveyDetails?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final question = cubit.testChoosesTimeModel.surveyDetails?[index].question ?? Question();
                                          final answers = question.answers ?? [];
                                          final controller = TextEditingController(text: answers.isNotEmpty ? answers[0] : "");


                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: NormalTextWidget(
                                              controller: controller ,
                                              cubit: cubit,

                                              question: cubit.testChoosesTimeModel.surveyDetails?[index].question??Question(),

                                              answersText: cubit.testChoosesTimeModel.surveyDetails?[index].question?.answers??[],
                                              questionImage: cubit.testChoosesTimeModel.surveyDetails?[index].question?.image??"",
                                              indexQ: index,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),

                                if(cubit.testChoosesTimeModel.surveyDetails?[0].question?.type!="text")
                              Visibility(
                                visible: cubit.isStartTest ||cubit.isStopTest,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: cubit.testChoosesTimeModel.surveyDetails?.length ?? 0,
                                      itemBuilder: (context, index) {

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: QuizOptionSelector(

                                            indexQ: index,
                                            isAnswered: cubit.isQuestionAnswer.containsKey(index),
                                            isSelected: cubit.isQuestionAnswer.containsKey(index),
                                            isSelectedCorrect: cubit.isQuestionAnswer[index] ?? false,
                                            colorText: Colors.black,
                                            colorAnswer: cubit.isQuestionAnswer.containsKey(index)
                                                ? (cubit.isQuestionAnswer[index]! ? Colors.green : Colors.red)
                                                : Colors.blue.withOpacity(0.1),
                                            option: cubit.testChoosesTimeModel.surveyDetails?[index].question?.arOptions ?? [],
                                            question: cubit.testChoosesTimeModel.surveyDetails?[index].question ?? Question(),
                                            onAnswerSelected: (indexAnswer) {
                                              if (!cubit.isQuestionAnswer.containsKey(index)) {
                                                List<String> correctAnswers = cubit.testChoosesTimeModel.surveyDetails?[index].question?.answers ?? [];
                                                bool isCorrect = correctAnswers.contains(indexAnswer.toString());
                                                cubit.setIndexQuestionInList(index: index, isCorrect: isCorrect).then((_)=>{
                                                  if(cubit.isStopTest){
                                                    setState(() {
                                                      _remainingTime = cubit.remainingTime.value;
                                                    }),
                                                    _toggleTest(),
                                                  }
                                                });

                                              }
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              if (cubit.isStopTest)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 5.0,
                                      percent: cubit.isQuestionAnswer.values.where((value) => value).length / cubit.testChoosesTimeModel.surveyDetails!.length,
                                      center: Text(
                                        "${(cubit.isQuestionAnswer.values.where((value) => value).length / cubit.testChoosesTimeModel.surveyDetails!.length * 100).round()}%",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      progressColor: Colors.green,
                                    ),
                                    SizedBox(height: 20),
                                    CustomText(
                                      text: cubit.getFeedbackMessage(
                                        (cubit.isQuestionAnswer.values.where((value) => value).length / cubit.testChoosesTimeModel.surveyDetails!.length * 100).round(),
                                      ),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.blackColor,
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                            ],
                          ),
                          if(cubit.testType == "puzzle")
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.testChoosesTimeModel.surveyDetails?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: RotatingImage(
                                    questionImage: cubit.testChoosesTimeModel.surveyDetails?[index].question?.image??"",
                                    answerImage:cubit.testChoosesTimeModel.surveyDetails?[index].question?.secondImage ?? "",
                                    answerText:  cubit.testChoosesTimeModel.surveyDetails?[index].question?.answers?[0]??"",
                                    isAnswerImage: cubit.testChoosesTimeModel.surveyDetails?[index].question?.answers?[0]=="puzzle" ?? false,
                                    questionText: cubit.testChoosesTimeModel.surveyDetails?[index].question?.content?[0]??"",
                                    isQuestionImage: cubit.testChoosesTimeModel.surveyDetails?[index].question?.content?[0]=="puzzle" ?? false,
                                    onRotationComplete:() {
                                      print('Rotation complete for item $index');
                                      // Example: Update cubit state or call a function
                                      // cubit.handleRotationComplete(index);
                                    },
                                    rotationDuration: Duration(seconds: index + 1),
                                  ),
                                );
                              },
                            ),
                          if(cubit.testType == "sudden_death")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(cubit.isStopTest)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Center(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                                          width: MediaQuery.of(context).size.width*0.7,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.1),
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: CustomText(
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp,
                                              text: "${cubit.listDeath.length}/${cubit.testChoosesTimeSuddenModel.surveyDetails![0].question!.answers!.keys.length}",
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                Visibility(
                                  visible: cubit.isStartTest ||cubit.isStopTest,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SuddenDeathWidget(
                                        question: cubit.testChoosesTimeSuddenModel.surveyDetails?[0].question??QuestionDeath(),
                                      cubit: cubit,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                if (cubit.isStopTest)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 60.0,
                                        lineWidth: 5.0,
                                        percent: cubit.isQuestionAnswer.values.where((value) => value).length / cubit.testChoosesTimeSuddenModel.surveyDetails![0].question!.arOptions!.length,
                                        center: Text(
                                          "${(cubit.listDeath.length / cubit.testChoosesTimeSuddenModel.surveyDetails![0].question!.arOptions!.length * 100).round()}%",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        progressColor: Colors.green,
                                      ),
                                      SizedBox(height: 20),
                                      CustomText(
                                        text: cubit.getFeedbackMessage(
                                          (cubit.listDeath.length / cubit.testChoosesTimeSuddenModel.surveyDetails![0].question!.arOptions!.length * 100).round(),
                                        ),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.blackColor,
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                              ],
                            ),

                          LoadingManager(
                            isLoading: cubit.isLoadingTestLike,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "${S.of(context).Similartests}",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blackColor,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Container(
                                  height: 322.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                    cubit.testLikeModel.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: index == 0 ? 20 : 15,
                                          ),
                                          BestSellingCard(

                                              goToDetails:  (){

                                                cubit.stopTest();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => TestDetailsScreen(test: cubit.testLikeModel.data?[index] ?? MostPopularData() ,),
                                                  ),
                                                );
                                              },

                                              image: "${Config.storageImage}/${cubit.testLikeModel.data?[index].image}",

                                              price:"",

                                              productName:"${cubit.testLikeModel.data?[index].arName}"
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(cubit.testType == "top_ten"&&cubit.testType != "puzzle")
                  Positioned(
                    top: 50,
                    child:  Visibility(
                      visible: cubit.isStartTest,
                      child: Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.9,
                          color: Colors.white,
                          child: CustomTextFormField(

                            onChanged: (value) {
                              if (cubit.answersInput.contains(cubit.inputText.text)) {
                                int index = cubit.testChoosesTimeModel.surveyDetails
                                    ?.indexWhere((detail) =>
                                detail.question?.answers?.contains(cubit.inputText.text) ?? false) ??
                                    -1;

                                if (index != -1) {

                                  cubit.setInputAnswers(index: index, answer: cubit.inputText.text).then((_)=>{
                                    if(cubit.isStopTest){
                                      setState(() {
                                        _remainingTime = cubit.remainingTime.value;
                                      }),
                                      _toggleTest(),
                                    }

                                  });
                                }
                              }
                            },
                            mycontroller: cubit.inputText,
                            isEmpty: false,
                            hintText: "اكتب الاجابة هنا...",
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(cubit.testType != "puzzle")
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.4,
                            child: FloatingActionButton.extended(
                              heroTag: "1111",
                              onPressed: () {
                                if (cubit.isStartTest) {
                                  if(cubit.testType=="sudden_death"){
                                    for (int index = 0; index < cubit.testChoosesTimeSuddenModel.surveyDetails![0].question!.arOptions!.length; index++) {
                                      final isCorrect = cubit.testChoosesTimeSuddenModel.surveyDetails![0].question?.answers?[index.toString()] == 'true';
                                      // answerStatus![index] = isCorrect;
                                      cubit.setIndexQuestionInList(index: index, isCorrect: isCorrect).then((_)=>{
                                        if(cubit.isStopTest){
                                          setState(() {
                                            _remainingTime = cubit.remainingTime.value;
                                          }),
                                          _toggleTest(),
                                        }
                                      });
                                    }
                                  }

                                  cubit.endTest().then((_)=>{
                                    setState(() {
                                      _remainingTime = cubit.remainingTime.value;
                                    }),
                                    _toggleTest(),
                                  });

                                } else {
                                  cubit.startTest().then((_)=>{
                                    setState(() {
                                      _remainingTime = cubit.remainingTime.value;
                                    }),
                                    _toggleTest(),
                                  });
                                }
                              },
                              backgroundColor: cubit.isStartTest ? Colors.red : Colors.green,
                              label: Row(
                                children: [
                                  Text(
                                    cubit.isStartTest ? S.of(context).StopTest : S.of(context).StartTest,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 7.5),
                                  Icon(
                                    cubit.isStartTest ? Icons.logout : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.4,
                            child: FloatingActionButton.extended(
                              heroTag: "2222",
                              onPressed: null, // No action needed
                              backgroundColor: AppColor.primary1Color,
                              label: Text(
                                _formatTime(_remainingTime),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            );
          }),
    );
  }
}
