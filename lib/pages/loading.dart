import 'dart:async';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:sizer/sizer.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading>  {

  void getWeather() async {

    Weather instance = Weather(lat: '', lon: '', city: 'Current position', flag: 'geolocation.png', currentPosition: true);
    await instance.getWeather();

    Timer(const Duration(milliseconds: 400), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'city': instance.city,
        'temp': instance.temp,
        'feelsLike': instance.feelsLike,
        'tempMax': instance.tempMax,
        'tempMin': instance.tempMin,
        'humidity': instance.humidity,
        'iconId': instance.iconId,
        'windSpeed': instance.windSpeed,
        'currentTime': instance.currentTime,
        'isDayTime': instance.isDayTime,
        'description': instance.description,
        'weatherList': instance.hoursWeatherList,
        'weatherDayList': instance.daysWeatherList,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.indigo])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, 25.h, 0, 0),
          child: Center(
            child: Column(
              children: [
                Text('Weather app',
                  style: TextStyle(
                      fontSize: 50.sp,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlower'),
                ),
                SizedBox(height: 5.h),
                OpacityAnimatedWidget.tween(
                    duration: const Duration(milliseconds: 900),
                    child: const Image(image: AssetImage('assets/icons/weather_app.png'),height: 300, width: 300,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
