import 'package:flutter/material.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/shared/styles/color.dart';

class InputTableWidget extends StatelessWidget {
  final List<SurveyChoosesTimeDetail> surveyDetails;
  final Map<int, String> inputMapAnswers;
final List<String> unCorrectAnswers ;
  const InputTableWidget({
    super.key,
    required this.surveyDetails,
    required this.inputMapAnswers, required this.unCorrectAnswers,
  });

  @override
  Widget build(BuildContext context) {
    if (surveyDetails.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstQuestion = surveyDetails[0].question?.content?.first ?? 'السؤال';
    final firstAnswer = surveyDetails[0].question?.answers?.first ?? 'الإجابة';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        color: Colors.white,
        child: Center(
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(AppColor.borderInput),
            dataRowColor: WidgetStateProperty.all(Colors.white),
            horizontalMargin: 10,
            dataRowMaxHeight: 75 ,
            border: TableBorder.all(color: AppColor.borderInput),
            columns: [
              DataColumn(
                label: Text(
                  firstQuestion,
                  style: const TextStyle(color: AppColor.primary1Color),
                ),
              ),
              DataColumn(
                label: Text(
                  firstAnswer,
                  style: const TextStyle(color: AppColor.primary1Color),
                ),
              ),
            ],
            columnSpacing: MediaQuery.of(context).size.width * 0.38,
            rows: surveyDetails
                .asMap()
                .entries
                .skip(1) // Skips the first element
                .map((entry) {
              int index = entry.key;
              SurveyChoosesTimeDetail detail = entry.value;

              String correctAnswer = detail.question?.answers?.first ?? '        ';
              String displayedAnswer = "          ";
              Color answerColor = Colors.black;

              // Check if the answer exists in the map
              if (inputMapAnswers.containsKey(index)) {
                String userAnswer = inputMapAnswers[index]!;

                if (userAnswer == correctAnswer) {
                  displayedAnswer = userAnswer;
                  answerColor = unCorrectAnswers.contains(correctAnswer)? Colors.red:Colors.green;
                } else {
                  displayedAnswer = userAnswer;
                  answerColor = unCorrectAnswers.contains(correctAnswer)? Colors.red:Colors.green;
                }
              }

              return DataRow(

                  cells: [
                DataCell(

                  Text(
                    detail.question?.content?.first ?? '        ',
                    style: const TextStyle(color: AppColor.primary1Color),
                  ),
                ),
                DataCell(

                  Text(
                    displayedAnswer,
                    style: TextStyle(color: answerColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}