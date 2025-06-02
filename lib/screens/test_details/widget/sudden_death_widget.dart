import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/cubit/test_details/cubit.dart';
import 'package:robquiz/model/network/test_details_input_model.dart';
import 'package:robquiz/shared/customs/custom_text.dart';
import 'package:robquiz/shared/styles/color.dart';

class SuddenDeathWidget extends StatefulWidget {
  final QuestionDeath question;
  final TestsDetailsCubit cubit;

  const SuddenDeathWidget({Key? key, required this.question, required this.cubit}) : super(key: key);

  @override
  _SuddenDeathWidgetState createState() => _SuddenDeathWidgetState();
}

class _SuddenDeathWidgetState extends State<SuddenDeathWidget> {
  int? selectedIndex;
  Map<int, bool>? answerStatus; // Store the status of all answers

  @override
  void initState() {
    super.initState();
    answerStatus = {};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.question.content ?? '',
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.primary1Color,
        ),
        const SizedBox(height: 10),

        /// Display Options in 2 Columns
        if (widget.question.arOptions != null)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3,
            ),
            itemCount: widget.question.arOptions!.length,
            itemBuilder: (context, index) {
              final option = widget.question.arOptions![index];
              final isCorrect = widget.question.answers?[index.toString()] == 'true';
              final isSelected = selectedIndex == index;
              final bool isAnswered = widget.cubit.isQuestionAnswer.keys.contains(index);

              return GestureDetector(
                onTap: isSelected || isAnswered|| !widget.cubit.isStartTest
                    ? null
                    : () {
                  setState(() {
                    selectedIndex = index;

                    if (isCorrect) {
                      widget.cubit.listDeath.add(isCorrect.toString());
                      // ✅ Correct answer selected
                      widget.cubit.setIndexQuestionInList(index: index, isCorrect: true);
                      answerStatus![index] = true;
                    } else {
                      // ❌ Incorrect answer selected
                      widget.cubit.setIndexQuestionInList(index: index, isCorrect: false);
                      answerStatus![index] = false;

                      // ➡️ End the test and reveal all answers
                      _revealAnswers();
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isAnswered
                        ? (isCorrect  ? Colors.green : Colors.red) // Show correct/incorrect color
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isAnswered
                          ?  (isCorrect  ? Colors.green : Colors.red)
                          : Colors.grey,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: option,
                    fontSize: option.length > 10 ? 10.sp : 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isAnswered ? Colors.white : AppColor.primary1Color,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  /// 🔥 Function to Reveal All Answers and End Test
  void _revealAnswers() {
    setState(() {
      for (int index = 0; index < widget.question.arOptions!.length; index++) {
        final isCorrect = widget.question.answers?[index.toString()] == 'true';
        answerStatus![index] = isCorrect;
        widget.cubit.setIndexQuestionInList(index: index, isCorrect: isCorrect);
      }
    });

    // End the test after revealing answers
    widget.cubit.endTest();
  }
}
