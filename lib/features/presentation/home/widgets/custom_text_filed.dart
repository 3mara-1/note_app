import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color? fillColor;
  final TextStyle? hintStyle;

  const CustomTextFiled({
    super.key,
    required this.controller,
    this.hintStyle,
    this.fillColor,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 150,
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: hintStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2.6, color: Color(0xff000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2.6, color: Color(0xff000000)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2.6, color: Color(0xff000000)),
          ),
        ),
      ),
    );
  }
}