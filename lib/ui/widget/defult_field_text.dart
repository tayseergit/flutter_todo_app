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
    this.readonly = false,
  });
  // void function() onTap;
  String text, hinttext;
  Widget? suffix;
  TextEditingController controller;
  TextInputType? keyboard;
  bool readonly;
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
          readOnly: readonly,
          // onTap: onTap,
          controller: controller,
          keyboardType: keyboard,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600]),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hinttext,
              hintStyle: TextStyle(color: Colors.grey[600]),
              suffixIcon: suffix,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ],
    );
  }
}
