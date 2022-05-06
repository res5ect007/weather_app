import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/services/weather.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading>  {

  void GetWeather() async {

    // Position position = GetCurrentPosition() as Position;
    Weather instance = Weather(city: 'Kyiv', lat: '50.45', lon: '30.52', flag: 'ukraine.png');
    await instance.getWeather();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('city', 'Kyiv');
    await prefs.setString('lat', '50.45');
    await prefs.setString('lon', '30.52');
    await prefs.setString('flag', 'ukraine.png');

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
  }

  @override
  void initState() {
    super.initState();
    GetWeather();
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
          padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
          child: Center(
            child: Column(
              children: [
                Text('Weather app',
                  style: TextStyle(
                      fontSize: 60.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontFamily: 'IndieFlower'),
                ),
                SizedBox(height: 40),
                OpacityAnimatedWidget.tween(
                    duration: Duration(milliseconds: 900),
                    child: Image(image: AssetImage('assets/icons/weather_app.png'),height: 300, width: 300,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
