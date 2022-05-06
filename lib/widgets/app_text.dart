import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  String text;
  Color color;
  String font;

  AppText({required this.text, this.color = Colors.white, this.size = 18.0, this.font = 'Nunito'});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontFamily: font));
  }
}
