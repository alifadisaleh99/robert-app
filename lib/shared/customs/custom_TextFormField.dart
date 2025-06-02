import 'package:flutter/material.dart';
import 'package:robquiz/shared/customs/base_error_text.dart';

import '../styles/color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextAlign textAlign;
  final String? hintText;
  final TextInputType keyboardType;
  final void Function(String? newValue)? onSave;
  final TextEditingController? mycontroller;
  final String? errorMessage;
  final String? emptyMessage;
  final String? falseMessage;
  final bool isAppColor;
  final bool isError;
  final bool isEmpty;
  final bool isFalse;
  final bool? isPassword;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final bool readOnly;
  final void Function()? onTap;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final double height;

  const CustomTextFormField({
    this.textAlign = TextAlign.start,
    this.hintText = '',
    this.onSave,
    this.mycontroller,
    this.keyboardType = TextInputType.name,
    super.key,
    this.errorMessage,
    this.isAppColor = false,
    this.isError = false,
    this.onTap,
    this.readOnly = false,
    required this.isEmpty,
    this.emptyMessage,
    this.isFalse = false,
    this.falseMessage,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
    this.onPressed,
    this.onChanged,
    this.height = 40,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    String initialValue = mycontroller?.text ?? '';

    bool hasValueChanged() {
      return mycontroller?.text != initialValue;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
                child: TextFormField(
                  cursorColor: AppColor.primary1Color,
                  obscureText: isPassword!,
                  readOnly: readOnly,
                  onTap: onTap,
                  controller: mycontroller,
                  textAlign: textAlign,
                  keyboardType: keyboardType,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLength: null,
                  decoration: InputDecoration(
                    focusColor: AppColor.primary1Color,
                    hintText: hintText,
                    alignLabelWithHint: true,
                    isDense: true,
                    hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyColor),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:(isError||isEmpty ||isFalse)?Colors.redAccent: (isAppColor) ?AppColor.primary1Color :AppColor.greyColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary1Color),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    suffixIcon: suffix != null
                        ? IconButton(
                      onPressed: suffixPressed,
                      icon: Icon(
                        suffix,
                        color: AppColor.greyColor,
                      ),
                    )
                        : null,
                  ),
                  onSaved: onSave,
                  onChanged: onChanged,
                  onFieldSubmitted: onFieldSubmitted,
                ),
              ),
              if (isError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.red,
                      ),
                      BaseErrorText(error: errorMessage),
                    ],
                  ),
                ),
              if (isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.red,
                      ),
                      BaseErrorText(error: emptyMessage),
                    ],
                  ),
                ),
              if (isFalse)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.red,
                      ),
                      BaseErrorText(error: falseMessage),
                    ],
                  ),
                ),
            ],
          )),
    );
  }
}
