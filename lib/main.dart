import 'package:flutter/material.dart';
import 'package:weather_app/pages/choose_location.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/loading.dart';
import 'package:weather_app/pages/settings.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const Loading(),
              '/home': (context) => const Home(),
              '/location': (context) => const ChooseLocation(),
              '/settings': (context) => const Settings(),
            },
          );
        }
    );
  }
}

