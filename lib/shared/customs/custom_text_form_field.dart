// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../styles/color.dart';
// import 'base_error_text.dart';
//
//
//
// class CustomTextFormField extends StatelessWidget {
//   final TextAlign textAlign;
//   final String? hintText;
//   final TextInputType keyboardType;
//   final void Function(String? newValue)? onSave;
//   final String? Function(String?) validator;
//   final TextEditingController? mycontroller;
//   final String? errorMessage;
//   final String? emptyMessage;
//   final String? falseMessage;
//   final bool isError;
//   final bool isEmpty;
//   final bool isFalse;
//   final bool? isPassword;
//   final IconData? suffix;
//   final void Function()? suffixPressed;
//   final bool readOnly;
//   final void Function()? onTap;
//   final bool isBirth;
//   final void Function()? onPressed;
//   final void Function(String)? onChanged;
//   final double height;
//
//   const CustomTextFormField({
//     this.textAlign = TextAlign.start,
//     this.hintText = '',
//     this.onSave,
//     required this.validator,
//     this.mycontroller,
//     this.keyboardType = TextInputType.name,
//     super.key,
//     this.errorMessage,
//     this.isError = false,
//     this.onTap,
//     this.readOnly = false,
//     required this.isEmpty,
//     this.emptyMessage,
//     this.isFalse = false,
//     this.falseMessage,
//     this.isPassword = false,
//     this.suffix,
//     this.suffixPressed,
//     this.isBirth = false,
//     this.onPressed,
//     this.onChanged,
//     this.height = 50,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: SizedBox(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: height,
//                 child: TextFormField(
//                   obscureText: isPassword!,
//                   readOnly: readOnly,
//                   onTap: onTap,
//                   controller: mycontroller,
//                   textAlign: textAlign,
//                   keyboardType: keyboardType,
//                   style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize:  12.h,
//                       fontWeight: FontWeight.w500,
//                       color:  AppColor.blackColorApp,),
//                   decoration: InputDecoration(
//                     // suffix: SvgPicture.asset(AppImageAsset.calendar),
//                       hintText: hintText,
//                       hintStyle: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontSize: 12.h,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.grayText),
//                       contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       enabledBorder:  const OutlineInputBorder(
//                         borderSide: BorderSide(color: AppColor.grayText),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       suffixIcon: suffix != null
//                           ? IconButton(
//                         onPressed: suffixPressed,
//                         icon: Icon(
//                           suffix,
//                           color: AppColor.goldColorApp,
//                           size:  24.h,
//                         ),
//                       )
//                           : null,
//                       focusedBorder:  const OutlineInputBorder(
//                         borderSide: BorderSide(color: AppColor.goldColorApp,),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       errorBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.redAccent),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       filled: false,
//                       fillColor: Colors.white,),
//                   onSaved: onSave,
//                   validator: validator,
//                   onChanged: onChanged,
//                 ),
//               ),
//               if (isError)
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.info_outline,
//                       color: Colors.red,
//                     ),
//                     BaseErrorText(error: errorMessage),
//                   ],
//                 ),
//               if (isEmpty)
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.info_outline,
//                       color: Colors.red,
//                     ),
//                     Expanded(child: BaseErrorText(error: emptyMessage)),
//                   ],
//                 ),
//               if (isFalse)
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.info_outline,
//                       color: Colors.red,
//                     ),
//                     BaseErrorText(error: falseMessage),
//                   ],
//                 ),
//             ],
//           )),
//     );
//   }
// }
