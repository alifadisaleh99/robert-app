import 'package:flutter/material.dart';
import 'package:robquiz/shared/customs/custom_text.dart';

class BaseErrorText extends StatelessWidget {
  final String? error;
  const BaseErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    if (error == null || error!.isEmpty) return const SizedBox();
    return CustomText(
        text: error ?? "",
        color: Colors.red.shade900,
        fontSize: 12,);
  }
}
