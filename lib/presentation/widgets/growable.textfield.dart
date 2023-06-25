// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'customs/new.textformfield.dart';
import 'customs/text.dart';

class GrowableTextField extends StatefulWidget {
  final List<TextEditingController> controllers;
  final String label;
  final String hint;
  final int? maxLines;
  const GrowableTextField({
    Key? key,
    required this.controllers,
    required this.label,
    required this.hint,
    this.maxLines,
  }) : super(key: key);

  @override
  State<GrowableTextField> createState() => _GrowableTextFieldState();
}

class _GrowableTextFieldState extends State<GrowableTextField> {
  void _addTextField() {
    setState(() {
      // Add a new controller when a new TextField is added
      widget.controllers.add(TextEditingController());
    });
  }

  void _removeTextField(int index) {
    setState(() {
      // Remove the controller and corresponding TextField
      widget.controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      margin: EdgeInsets.all(1.h),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(widget.label),
              SizedBox(width: 1.w),
              IconButton(
                onPressed: _addTextField,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(
            height: widget.controllers.isEmpty
                ? 0
                : widget.controllers.length < 2
                    ? 70
                    : widget.controllers.length < 3
                        ? 140
                        : widget.controllers.length < 4
                            ? 210
                            : 280,
            width: double.infinity,
            child: ListView.builder(
              itemCount: widget.controllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: NewTextformfield(
                    hint: widget.hint,
                    controller: widget.controllers[index],
                    color: Colors.black,
                    maxLines: widget.maxLines,
                    suffix: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => _removeTextField(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
