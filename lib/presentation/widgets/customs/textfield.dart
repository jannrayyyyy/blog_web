import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Widget? suffix;
  final bool? isObscure;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final GlobalKey<FormState>? formKey;
  final double? radius;
  final Color? borderColor;
  final Color? bgColor;
  final bool? lastTextField;
  final int? maxLength;
  final TextInputAction? action;
  final String? initialValue;
  final int? maxHeight;
  const CustomTextField({
    super.key,
    this.controller,
    required this.hint,
    this.suffix,
    this.isObscure,
    this.prefix,
    this.validator,
    this.keyboard,
    this.formKey,
    this.radius,
    this.borderColor,
    this.bgColor,
    this.lastTextField,
    this.maxLength,
    this.action,
    this.initialValue,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return TextFormField(
      key: formKey,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      textInputAction: action,
      keyboardType: keyboard,
      maxLength: maxLength,
      obscureText: isObscure ?? false,
      validator: validator,
      onEditingComplete: () {
        if (lastTextField ?? false) {
          node.unfocus();
        }
        {
          node.nextFocus();
        }
      },
      maxLines: maxHeight,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix,
        prefixIcon: prefix,
        counterText: '',
        fillColor: bgColor ?? Colors.grey.shade900,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
