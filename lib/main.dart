import 'package:flutter/material.dart';
import 'package:weather_app/pages/about.dart';
import 'package:weather_app/pages/choose_language.dart';
import 'package:weather_app/pages/choose_location.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/loading.dart';
import 'package:weather_app/pages/settings.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/services/language_model.dart';
import 'package:weather_app/services/theme_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => LanguageModel()),
          ChangeNotifierProvider(create: (_) => ThemeModel())
        ],
    child:  Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              //theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => Loading(),
                '/home': (context) => Home(),
                '/location': (context) => ChooseLocation(),
                '/settings': (context) => Settings(),
                '/language': (context) => ChooseLanguage(),
                '/about': (context) => AboutPage(),
              },
            );
          }
      ),
    );
  }
}