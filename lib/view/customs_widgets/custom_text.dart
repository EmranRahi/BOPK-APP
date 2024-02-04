import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {

  final String? title;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  FontStyle? fontStyle; // Add FontStyle property
  TextDecoration? decoration; // Add the decoration property
  String? googleFont; // Added property to specify Google Font
  TextOverflow? textOverflow;
  TextOverflow? textOverflow1;
  int? max;

  CustomText(
      {super.key,
        this.title,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.fontStyle, // Include fontStyle in the constructor
        this.decoration,
        this.googleFont, // Include Google Font in the constructor
        this.textOverflow, // Include Google Font in the constructor
        this.max, // Include Google Font in the constructor
        this.textOverflow1

      });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      overflow: textOverflow ?? TextOverflow.clip, // Use provided textOverflow or default to TextOverflow.c
      // overflow:
      // maxLines: max,
      // style: TextStyle(fontSize: fontSize,
      //   fontWeight: fontWeight,
      //   color: color,)
      style: GoogleFonts.getFont(googleFont ?? 'Roboto', textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle ,
        color: color,
        decoration: decoration,
        overflow: textOverflow1,
        // overflow: TextOverflow.ellipsis,
      )
      ),
    );
  }
}
