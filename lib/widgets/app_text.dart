import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final String font;

  const AppText({Key? key, required this.text, this.color = Colors.white, this.size = 12.0, this.font = 'Roboto'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: color,
            fontSize: size.sp,
            fontFamily: font));
  }
}
