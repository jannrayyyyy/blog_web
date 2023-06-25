// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NewTextformfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Color? color;
  final Widget? suffix;
  final int? maxLines;
  const NewTextformfield({
    Key? key,
    this.controller,
    required this.hint,
    this.color,
    this.suffix,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: color ?? Colors.white),
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: suffix,
        labelStyle: TextStyle(color: color ?? Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? Colors.white),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color ?? Colors.white),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field should not be empty!';
        }
        return null;
      },
    );
  }
}
