import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:robquiz/shared/customs/base_error_text.dart';
import 'package:robquiz/shared/network/local/cache_helper.dart';
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
    this.height = 50,
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
            height: height.h,
            child: TextFormField(

              inputFormatters: [
                if(keyboardType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly,
                if(keyboardType == TextInputType.number)
                LengthLimitingTextInputFormatter(8),   // Restricts input to 8 characters
              ],
              cursorColor: AppColor.blackColor,
              obscureText: isPassword!,
              readOnly: readOnly,
              onTap: onTap,
              controller: mycontroller,
              textAlign: textAlign,
              keyboardType: keyboardType,
              style: TextStyle(
                fontFamily: CacheHelper.getData(key: 'locale') == "ar"
                    ? "Almarai"
                    : "Inter",
                color: AppColor.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLength: null,
              decoration: InputDecoration(
                focusColor: AppColor.blackColor,
                hintText: hintText,
                alignLabelWithHint: true,
                isDense: true,
                hintStyle: TextStyle(
                    fontFamily: CacheHelper.getData(key: 'locale') == "ar"
                        ? "Almarai"
                        : "Inter",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor),
                contentPadding:
                    const EdgeInsets.symmetric( vertical: 10),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: (isError || isEmpty)
                        ? Colors.redAccent
                        : AppColor.borderInput,
                    width: 1.0, // Adjust border width
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.borderInput,
                    width: 1.0,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.borderInput,
                    width: 1.0,
                  ),
                ),
                suffixIcon: suffix != null
                    ? IconButton(
                        onPressed: suffixPressed,
                        icon: Icon(
                          suffix,
                          color: AppColor.blackColor,
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
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.red,
                ),
                BaseErrorText(error: errorMessage),
              ],
            ),
          if (isEmpty)
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.red,
                ),
                BaseErrorText(error: emptyMessage),
              ],
            ),
          if (isFalse)
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.red,
                ),
                BaseErrorText(error: falseMessage),
              ],
            ),
        ],
      )),
    );
  }
}
