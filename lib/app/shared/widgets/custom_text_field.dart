import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'package:uni_lecture/app/shared/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final bool? enabled;
  final TextInputType keyBoardType;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffix;
  final int maxLines;
  final int? maxLength;
  final String? fontFamily;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {Key? key,
      this.controller,
      this.onChanged,
      required this.hintText,
      required this.labelText,
      this.onTap,
      this.validator,
      this.inputFormatters,
      this.fontFamily,
      this.suffix,
      this.maxLength,
      this.keyBoardType = TextInputType.text,
      this.maxLines = 1,
      this.obscureText = false,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        maxLines: maxLines,
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        maxLength: maxLength,
        obscuringCharacter: '●',
        style: AppText.semiBoldText.copyWith(color:  Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
        keyboardType: keyBoardType,
        inputFormatters: inputFormatters,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          counterText: '',
          fillColor: AppColors.kBgColor,
          hintText: hintText,
          errorStyle:  const TextStyle(color: Colors.red, fontWeight: FontWeight.w300, fontSize: 10),
          hintStyle:  TextStyle(color: AppColors.kPrimaryColor.withOpacity(0.4), fontWeight: FontWeight.w400, fontSize: 12),
          filled: true,
          suffixIcon: suffix,
          labelText: labelText,
          labelStyle:  TextStyle(color: AppColors.kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 13),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: AppColors.kPrimaryColor,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: AppColors.kPrimaryColor,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: AppColors.kPrimaryColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: AppColors.kPrimaryColor,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: AppColors.kPrimaryColor,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(
              width: 0.5,
              color: Colors.red,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
