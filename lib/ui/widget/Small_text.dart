import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo/main.dart';

class Smalltext extends StatelessWidget {
  String text;
  double size, letterSpacing;
  FontWeight weight;
  Color? color;
  Smalltext(this.text,
      {super.key,
      this.size = 16,
      this.weight = FontWeight.w500,
      this.color,
      this.letterSpacing = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis, // Shows "..."
      maxLines: 1, // Limits text to 1 line
      style: TextStyle(
        fontSize: size.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
