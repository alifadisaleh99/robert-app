import 'package:flutter/material.dart';
import 'package:robquiz/shared/styles/color.dart';
import 'custom_text.dart';

class CustomToast extends StatelessWidget {
  final bool isSccessToast;
  final String text;
  const CustomToast(
      {super.key, required this.text, required this.isSccessToast});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColor.yellowColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.yellowColor,
              border: const Border(
                bottom: BorderSide(color: AppColor.blackColor, width: 3.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isSccessToast
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: AppColor.blackColor,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomText(
                    text: text,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.close,
            color: AppColor.greyColor,
          )
        ],
      ),
    );
  }
}
