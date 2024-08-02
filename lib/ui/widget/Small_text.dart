import 'package:flutter/material.dart';

class Smalltext extends StatelessWidget {
  String text;
  double size, letterSpacing;
  FontWeight weight;
  Color color;
  Smalltext(this.text,
      {super.key,
      this.size = 20,
      this.weight = FontWeight.w500,
      this.color = Colors.black,
      this.letterSpacing = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
