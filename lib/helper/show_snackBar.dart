import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, Color contentColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Text(content, style: TextStyle(color: contentColor)),
    ),
  );
}
