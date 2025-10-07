import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final Color? fillColor;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.hintText,
    this.fillColor,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 80,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          helperText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2.5, color: Color(0xff000000)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2.5, color: Color(0xff000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2.5, color: Color(0xff000000)),
          ),
        ),
      ),
    );
  }
}