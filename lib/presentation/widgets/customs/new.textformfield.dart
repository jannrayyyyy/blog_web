import 'package:flutter/material.dart';

class NewTextformfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;

  const NewTextformfield({
    super.key,
    this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
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
