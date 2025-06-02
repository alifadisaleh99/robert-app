import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robquiz/cubit/test_details/cubit.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/styles/color.dart';

class NormalTextWidget extends StatefulWidget {
  final Question question;
  final int indexQ;
  final String questionImage;
  final List<String> answersText;
    final  TestsDetailsCubit cubit ;
    final TextEditingController? controller;

  const NormalTextWidget({
    super.key,
    required this.question,
    required this.indexQ,
    required this.questionImage,
    required this.answersText, required this.cubit, this.controller,
  });

  @override
  State<NormalTextWidget> createState() => _NormalTextWidgetState();
}

class _NormalTextWidgetState extends State<NormalTextWidget> {
  bool isAnswerCorrect = false;
  bool isReadOnly = false;

  void handleInputChange(String value) {
    if (widget.answersText.contains(value.trim())) {
      widget.cubit.setIndexQuestionInList(index: widget.indexQ,isCorrect: true);
      setState(() {
        isAnswerCorrect = true;
        isReadOnly = true;
      });
    } else {
      setState(() {
        isAnswerCorrect = false;
        isReadOnly = false;
      });
    }


  }
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize controller with the answer if available
    _controller = widget.controller ?? TextEditingController();
    if (widget.answersText.isNotEmpty) {
      _controller.text = widget.answersText[0]; // Pre-fill with first answer
    }
  }


  @override
  Widget build(BuildContext context) {

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
            "${widget.indexQ + 1}- ${(widget.question.content?.isNotEmpty ?? false) ? (widget.question.content?[0]) : ""}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.5,
              color: AppColor.blackColor,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
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
                imageUrl: "${Config.storageImage}/${widget.questionImage}",
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: widget.cubit.isQuestionAnswer[widget.indexQ]==true ? _controller:widget.cubit.isStopTest?_controller:null,
                      onChanged: handleInputChange,
                      style: TextStyle(
                        color: widget.cubit.isQuestionAnswer[widget.indexQ]==true ?Colors.green:widget.cubit.isStopTest==true?Colors.red: Colors.blue,
                      ),
                      readOnly: isReadOnly, // Set to true when answer is correct
                      decoration: InputDecoration(
                        hintText: "ادخل الاجابة هنا ...",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.cubit.isQuestionAnswer[widget.indexQ]==true ? Colors.green : widget.cubit.isStopTest==true?Colors.red: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: widget.cubit.isQuestionAnswer[widget.indexQ]==true ? Colors.green : widget.cubit.isStopTest==true?Colors.red: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    if (widget.cubit.isQuestionAnswer[widget.indexQ]==true)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'الإجابة صحيحة',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
