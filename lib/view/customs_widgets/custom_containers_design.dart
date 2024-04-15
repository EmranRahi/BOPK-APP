import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomContainer extends StatelessWidget {
  final Widget child;
  final ontap;
  final double? height;
  final double? width;
  final Color? color;
  // IconData? icon;
  double rd;
  bool? boxShadow = true;
   CustomContainer({super.key,
     required this.child,
    required this.ontap,
    this.height,
    this.width,
    this.color,
    // this.icon,
    this.boxShadow,
    required this.rd,});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ontap,
      child: Container(
        height: height ?? 10,
        width: width ?? 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? Color(0xFFE4E4E4),
            borderRadius: BorderRadius.circular(rd.r),
              // border: Border.all(color: CupertinoColors.systemGrey3),
            boxShadow: [
              BoxShadow(
                color: boxShadow == true
                    ? Color(0xffD9CDE7).withOpacity(0.3)
                    : Colors.transparent,
                blurRadius: 2.r,
                spreadRadius: 2.r,
                offset: Offset(0, 0),
              ),
            ]
        ),
        child: child,
      ),
    );
  }
}
