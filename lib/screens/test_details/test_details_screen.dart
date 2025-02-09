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
import 'package:robquiz/screens/home/widget/best_selling_card.dart';
import 'package:robquiz/screens/home/widget/row_see_all.dart';
import 'package:robquiz/screens/test_details/widget/custom_test_form.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/customs/loading_top.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';

class TestDetailsScreen extends StatelessWidget {
  final MostPopularData test;

  const TestDetailsScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestsDetailsCubit(test),
      child: BlocConsumer<TestsDetailsCubit, TestsDetailsState>(
          listener: (BuildContext context, TestsDetailsState state) {},
          builder: (BuildContext context, TestsDetailsState state) {
            TestsDetailsCubit cubit = TestsDetailsCubit.get(context);
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          if (cubit.isStartTest) {
                            cubit.endTest();
                          } else {
                            cubit.startTest();
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: FloatingActionButton.extended(
                        onPressed: null, // No action needed
                        backgroundColor: AppColor.primary1Color,
                        label: Text(
                          cubit.formatTime(cubit.remainingTime),
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
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100.h,
                            height: 150.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    "${Config.storageImage}/${test.image}",
                                  ),
                                  fit: BoxFit.cover),
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
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width*0.6,
                                child: CustomText(
                                  text: test.arName ?? "",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              CustomText(
                                text: test.notes ?? "",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),

                        ],
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
                                        isAnswered: cubit.isQuestionAnswer.containsKey(index), // Check if answered
                                        isSelected: cubit.isQuestionAnswer.containsKey(index), // Check if this option is selected
                                        isSelectedCorrect: cubit.isQuestionAnswer[index] ?? false, // Correct answer status
                                        colorText: Colors.black,
                                        colorAnswer: cubit.isQuestionAnswer.containsKey(index)
                                            ? (cubit.isQuestionAnswer[index]! ? Colors.green : Colors.red)
                                            : Colors.blue.withOpacity(0.1), // Default color before answering
                                        option: cubit.testChoosesTimeModel.surveyDetails?[index].question?.arOptions ?? [],
                                        question: cubit.testChoosesTimeModel.surveyDetails?[index].question ?? Question(),
                                        onAnswerSelected: (indexAnswer) {
                                          if (!cubit.isQuestionAnswer.containsKey(index)) {
                                            List<String> correctAnswers = cubit.testChoosesTimeModel.surveyDetails?[index].question?.answers ?? [];
                                            bool isCorrect = correctAnswers.contains(indexAnswer.toString());
                                            cubit.setIndexQuestionInList(index: index, isCorrect: isCorrect);

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
            );
          }),
    );
  }
}
