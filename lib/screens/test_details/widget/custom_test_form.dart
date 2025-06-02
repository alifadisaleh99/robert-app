import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';

class QuizOptionSelector extends StatelessWidget {
  final Question question;
  final void Function(int index)? onAnswerSelected;
  final List<String> option;
  final bool isSelected;


  final bool isSelectedCorrect;
  final Color colorText;
  final Color colorAnswer;
  final bool isAnswered;
  final int indexQ;

  const QuizOptionSelector({
    Key? key,
    required this.question,
    this.onAnswerSelected,
    required this.option,
    required this.isSelected,
    required this.colorText,
    required this.colorAnswer,
    required this.isSelectedCorrect,
    required this.isAnswered, required this.indexQ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> answerColors = List.generate(option.length, (index) {
      bool isOptionCorrect = question.answers?.contains(index.toString()) ?? false;

      if (isAnswered) {
        if (isOptionCorrect) {
          return Colors.green;
        } else if (isSelected && isSelectedCorrect) {
          return Colors.grey.withOpacity(0.1);
        } else {
          return Colors.red;
        }
      } else {
        return Colors.grey.withOpacity(0.1);
      }
    });
    List<Color> textColors = List.generate(option.length, (index) {
      bool isOptionCorrect = question.answers?.contains(index.toString()) ?? false;

      if (isAnswered) {
        if (isOptionCorrect) {

          return Colors.white;
        } else if (isSelected && isSelectedCorrect) {
          return AppColor.blackColor;
        } else {
          return Colors.white;
        }
      } else {

        return AppColor.blackColor;
      }
    });
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${indexQ+1}- ${(question.content?.length!=0&&question.content?.length!=null)?(question.content?[0]):""}" ?? '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.5,
              color: AppColor.blackColor,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          if(question.image!=""&&question.image!=null)
          CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColor.primary1Color,
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
            imageUrl: "${Config.storageImage}/${question.image}",
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          if (question.arOptions != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: question.arOptions!.length,
              itemBuilder: (context, index) {
                // Get the color for this answer
                Color answerColor = answerColors[index];
                Color textColor = textColors[index];

                return GestureDetector(
                  onTap: () => onAnswerSelected!(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: answerColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                          BoxShadow(
                            color: answerColor,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Text(
                      option[index],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),


        ],
      ),
    );
  }
}
