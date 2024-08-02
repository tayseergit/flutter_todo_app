import 'package:todo/ui/style/appColor.dart';
import 'package:flutter/material.dart';

class DefultBotton extends StatelessWidget {
  DefultBotton(
      {super.key,
      required this.onTap,
      this.hight = 50,
      this.width = 120,
      this.color = AppColor.primaryColor,
      this.radius = 20,
      this.alignment = Alignment.center,
      this.child});
  void Function() onTap;
  double hight, radius;
  double? width;
  Color color;
  Widget? child;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        height: hight,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}
