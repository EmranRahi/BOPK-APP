import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    Key? key,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderRadius,
    this.counterText,
    this.maxLines,
    this.color,
    this.obscureText = false,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.validator,
    this.contentPadding, // Add a contentPadding parameter
    this.borderSide = const BorderSide(), // Add a default value
    this.textInputAction,

  }) : super(key: key);

  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? fillColor;
  final double? borderRadius;
  final String? counterText;
  final int? maxLines;
  final Color? color;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator; // Define the validator function
  final EdgeInsets? contentPadding; // Add contentPadding property to the constructor
  final BorderSide? borderSide;
  final  TextInputAction? textInputAction;


  @override
  State<CustomTextFormFieldWidget> createState() => _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formKey,
      controller: widget.controller,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator:widget.validator, // Set the validator function
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
            // ?? EdgeInsets.fromLTRB(10, 10, 10, 0), // Use the provided contentPadding or default value
        fillColor: widget.color,
        filled: widget.fillColor,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        counterText: widget.counterText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.r),
          borderSide: widget.borderSide!, // Use the borderSide parameter
        ),
      ),
    );
  }
}
