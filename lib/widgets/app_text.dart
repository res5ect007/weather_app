import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/theme_styles.dart';
import '../services/theme_model.dart';

class AppText extends StatelessWidget {
  final double size;
  final String? text;
  final Color? color;
  final String font;
  final bool translate;
  final ThemeStyle themeStyle = ThemeStyle();

  AppText({Key? key, required this.text, this.color, this.size = 12.0, this.font = 'Roboto', this.translate = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
    return Text(text!,
        style: TextStyle(
            color: color ?? themeStyle.getFontColor(themeNotifier.isDark),
            fontSize: size.sp,
            fontFamily: font));
        }
    );
  }
}
