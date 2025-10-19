import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color? buttomColor;
  const MyButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttomColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap;
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        backgroundColor: buttomColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      child: Text(buttonText, style: TextStyle(fontSize: 16)),
    );
  }
}
