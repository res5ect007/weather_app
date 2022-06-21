import 'package:provider/provider.dart';
import 'package:weather_app/services/theme_styles.dart';
import '../services/theme_model.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final ThemeStyle themeStyle = ThemeStyle();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
    return Container(
      decoration: themeStyle.getBackground(themeNotifier.isDark),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
  );
}
}
