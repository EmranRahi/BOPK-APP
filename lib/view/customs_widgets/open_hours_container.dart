import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenHoursContainer extends StatefulWidget {
  final Widget child;
  final bool isChecked;
  final Widget customCheckbox; // Add a parameter for custom Checkbox

  const OpenHoursContainer({
    Key? key,
    required this.child,
    this.isChecked = false,
    required this.customCheckbox, // Provide a custom Checkbox widget
  }) : super(key: key);

  @override
  State<OpenHoursContainer> createState() => _OpenHoursContainerState();
}

class _OpenHoursContainerState extends State<OpenHoursContainer> {
  // late bool isChecked;
  // late String statusText;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   isChecked = widget.isChecked;
  //   statusText = isChecked ? 'Open' : 'Close';
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.grey, // Replace with your desired color
        borderRadius: BorderRadius.circular(10)
      ),
    
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            widget.child,
            Spacer(),
            widget.customCheckbox,
            Text("Open"), // Display status text
          ],
        ),
      ),
    );

  }


}
