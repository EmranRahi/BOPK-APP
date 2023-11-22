import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuItem<String>> items;
  final Function(String) onSelected;
  final Widget child;

  CustomPopupMenuButton({
    required this.items,
    required this.onSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        child: child,
        itemBuilder: (BuildContext context) {
          return items;
        },
      ),
    );
  }
}
