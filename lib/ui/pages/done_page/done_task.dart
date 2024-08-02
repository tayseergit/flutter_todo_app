import 'package:todo/ui/widget/Big_text.dart';
import 'package:flutter/material.dart';

class DoneTaskPage extends StatelessWidget {
  const DoneTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BigText(" done task "),
        Row(),
      ],
    );
  }
}
