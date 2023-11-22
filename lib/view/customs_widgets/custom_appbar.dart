import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget customAppBar1({

  bool? centerTitle,
  final Widget? leading,
  final Widget? action,
  final Widget? title,
  final Widget? flexibleSpace,
  double? elevation,
  Color? backgroundColor, // Add this property for custom color

}) {
  return AppBar(
    backgroundColor: backgroundColor ?? whiteColor,
    elevation: elevation,
    flexibleSpace:  flexibleSpace,
    leading: leading,
    title: title,
    centerTitle: centerTitle,
    actions: [
      action ?? SizedBox(),
    ],
  );
}
