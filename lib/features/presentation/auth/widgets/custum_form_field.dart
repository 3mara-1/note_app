import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? hintText;
  String? labelText;
  Color? fillColor;
  TextStyle? labelStyle;
  TextStyle? hintStyle;

  CustomFormField({
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
    final textStyle = Theme.of(context).textTheme;
    final colorStyle = Theme.of(context).colorScheme;

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
            // borderSide: BorderSide(width: 2, color: Color(0xff000000)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(width: 2.5, color: Color(0xff000000)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(width: 2.5, color: Color(0xff000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(width: 2.5, color: Color(0xff000000)),
          ),
        ),
      ),
    );
  }
}
