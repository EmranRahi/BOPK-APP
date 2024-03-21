import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {

  final String? title;

  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle; // Add FontStyle property
  TextDecoration? decoration; // Add the decoration property
  String? googleFont; // Added property to specify Google Font
  TextOverflow? textOverflow;
  // int? max;
  // final double? maxFontSize;
  // final double? minFontSize;
  final int? maxLine;

  CustomText(
      {super.key,
        this.title,
        this.color,
        this.fontWeight,
        this.fontStyle, // Include fontStyle in the constructor
        this.decoration,
        this.googleFont, // Include Google Font in the constructor
        this.textOverflow, // Include Google Font in the constructor
        // this.max, // Include Google Font in the constructor
        // this.maxFontSize,
        // this.minFontSize,
        this.maxLine,
        this.fontSize,

      });

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      maxLines: maxLine ?? 1,
      // maxFontSize: maxFontSize ?? 12,
      // minFontSize: minFontSize ?? 5,
      overflow: textOverflow,
      // wrapWords: true,
      // softWrap: true,

      style: GoogleFonts.getFont(googleFont ?? 'Roboto', textStyle: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle ,
        color: color,
        decoration: decoration,
         overflow: TextOverflow.ellipsis,
      )
      ),
    );
  }
}
