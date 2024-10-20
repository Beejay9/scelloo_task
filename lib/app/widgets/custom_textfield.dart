import 'package:flutter/material.dart';
import 'package:scelloo_task/app/constants/app_colors.dart';
import 'package:scelloo_task/app/constants/app_textsyle.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool autocorrect;
  final bool autofocus;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.hintText,
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.autocorrect = false,
    this.autofocus = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.initialValue,
    this.maxLength,
    this.onFieldSubmitted,
    this.onSaved,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onTap: onTap,
      autocorrect: autocorrect,
      autofocus: autofocus,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.regular(
          color: const Color.fromARGB(255, 181, 181, 181),
          fontSize: 15,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: AppColor.mainTextColor,
        suffixIcon: suffixIcon,
        suffixIconColor: AppColor.subTextColor,
        fillColor: const Color.fromARGB(255, 26, 26, 26),
        filled: true,
        helper: null,
      ),
      style: AppTextStyle.regular(
        color: const Color.fromARGB(255, 181, 181, 181),
        fontSize: 15,
      ),
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: const Color.fromARGB(255, 181, 181, 181),
      focusNode: focusNode,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
