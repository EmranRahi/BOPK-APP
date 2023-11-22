import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custom_Button_Widget extends StatelessWidget {
  Custom_Button_Widget({
    Key? key,
    required this.child,
    required this.ontap,
    this.height,
    this.width,
    this.color,
    this.icon,
    this.boxShadow,
    this.border, // Add border parameter
    required this.rd,

  }) : super(key: key);
  final Widget child;
  // ignore: prefer_typing_uninitialized_variables
  final ontap;
  final double? height;
  final double? width;
  final Color? color;
  IconData? icon;
  double rd;
  bool? boxShadow = true;
  final Border? border; // Define Border parameter

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ontap,
      child: Container(
        height: height ?? 48,
        width: width ?? 140,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? Color(0xFF009EFD),
            borderRadius: BorderRadius.circular(rd.r),
            border: border, // Use the provided border
            boxShadow: [
              BoxShadow(
                color: boxShadow == true
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.transparent,
                blurRadius: 4.r,
                spreadRadius: 2.r,
                offset: Offset(0, 4),
              ),
            ]),
        child: child,
      ),
    );
  }
}
