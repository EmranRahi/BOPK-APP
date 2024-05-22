import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenHoursContainer extends StatefulWidget {
  final Widget child;
  final bool isChecked;
  final Widget customCheckbox;

  const OpenHoursContainer({
    Key? key,
    required this.child,
    this.isChecked = false,
    required this.customCheckbox,
  }) : super(key: key);

  @override
  State<OpenHoursContainer> createState() => _OpenHoursContainerState();
}

class _OpenHoursContainerState extends State<OpenHoursContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50, // Set a fixed height
      decoration: BoxDecoration(
        color: Colors.grey, // Replace with your desired color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            widget.child,
            Spacer(),
            widget.customCheckbox,
            Text(widget.isChecked ? "Open" : "Closed"), // Display status text
          ],
        ),
      ),
    );
  }
}

