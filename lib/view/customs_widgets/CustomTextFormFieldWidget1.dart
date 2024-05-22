import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWidget1 extends StatefulWidget {
  const CustomTextFormFieldWidget1({
    Key? key,
    this.hint,
    this.controller,
    this.onChanged,
    this.borderRadius,
    this.color,
    this.textAlign,
    this.keyboardType, // New property for keyboard type
  }) : super(key: key);

  final String? hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final double? borderRadius;
  final Color? color;
  final TextAlign? textAlign;
  final TextInputType? keyboardType; // New property for keyboard type

  @override
  State<CustomTextFormFieldWidget1> createState() =>
      _CustomTextFormFieldWidgetState1();
}

class _CustomTextFormFieldWidgetState1 extends State<CustomTextFormFieldWidget1> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      textAlign: widget.textAlign ?? TextAlign.left,
      keyboardType: widget.keyboardType, // Set keyboard type
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
        ),
      ),
    );
  }
}

