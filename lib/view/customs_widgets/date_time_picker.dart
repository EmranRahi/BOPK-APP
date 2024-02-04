import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'constant_color.dart';

class DateTimePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DateTimePicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  bool isDOBselected = false;
  late DateTime DoB = DateTime.now();

  // void _showDataPicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime(2050),
  //
  //   ).then((value) {
  //     if (value != null) {
  //       setState(() {
  //         // Clear the date of birth field before selecting a new date
  //         isDOBselected = true;
  //         DoB = DateTime(value.year, value.month, value.day);
  //       });
  //     }
  //   });
  // }
  void _showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header background color
            hintColor: Colors.blue, // Color of the selected date
            colorScheme: ColorScheme.light(primary: greenColor2),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          // Clear the date of birth field before selecting a new date
          isDOBselected = true;
          DoB = DateTime(value.year, value.month, value.day);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              // Clear the date of birth field before selecting a new date
              isDOBselected = false;
              widget.onDateSelected(DoB);
              _showDataPicker();
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 14.5,
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(08.r),
                  color: Colors.white,
                  border: Border.all(
                    color: grayColor2
                  )
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDOBselected
                            ? DateFormat('dd/MM/yyyy').format(DoB)
                            : 'Select job Start Date',
                        style: GoogleFonts.roboto(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.calendar_month,color: greenColor2,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
