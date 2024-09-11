import 'package:flutter/material.dart';
import 'package:smart_code_mentor/components/constants.dart';

class SquareButton extends StatelessWidget {
  final Key? key;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const SquareButton({
    this.key,
    required this.text,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, 
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(
          vertical: 15.0, 
          horizontal: size,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
