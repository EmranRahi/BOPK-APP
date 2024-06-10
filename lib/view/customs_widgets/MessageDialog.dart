import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onPressed;

  const MessageDialog({
    required this.title,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
