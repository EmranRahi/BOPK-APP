import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {

  final String? title;
  // double? height;
  // double? width;
  // TextAlign? textAlign;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  FontStyle? fontStyle; // Add FontStyle property
  TextDecoration? decoration; // Add the decoration property

  CustomText(
      {super.key,
    this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle, // Include fontStyle in the constructor
    this.decoration,

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
         overflow: TextOverflow.ellipsis,
        // style: TextStyle(fontSize: fontSize,
        //   fontWeight: fontWeight,
        //   color: color,)
        style: GoogleFonts.aBeeZee(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle ,
          color: color,
          decoration: decoration,
        )
    );
  }
}
