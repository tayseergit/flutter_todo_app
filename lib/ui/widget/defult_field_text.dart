import 'package:todo/ui/widget/Small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefultFormText extends StatelessWidget {
  DefultFormText({
    super.key,
    required this.text,
    this.suffix,
    required this.controller,
    this.hinttext = '',
    this.keyboard,
  });
  // void function() onTap;
  String text, hinttext;
  Widget? suffix;
  TextEditingController controller;
  TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Smalltext(
          text,
          size: 20,
        ),
        TextFormField(
          // onTap: onTap,
          controller: controller,
          keyboardType: keyboard,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hinttext,
              suffixIcon: suffix,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ],
    );
  }
}
