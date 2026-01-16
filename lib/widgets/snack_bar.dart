import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackBar(
  BuildContext context,
  String message,
  Color? color, {
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: duration,
    ),
  );
}
