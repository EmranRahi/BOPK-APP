import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
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
            color: color ?? Color(0xFF004578),
            borderRadius: BorderRadius.circular(rd.r),
             // border: Border.all(color: grayColor),
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
