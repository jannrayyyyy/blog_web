import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  const CustomText(
    this.text, {
    super.key,
    this.align,
    this.maxLines,
    this.overflow,
    this.color,
    this.size,
    this.weight,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
      ),
    );
  }
}
