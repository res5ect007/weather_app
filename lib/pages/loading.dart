import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/services/weather.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // String key = '85810a93c46f0c45b6a19f56f9dcb2ad';
  // String cityName = 'Kyiv';
  void GetWeather() async {
    Weather instance = Weather(city: 'Kyiv', lat: '50.45', lon: '30.52', flag: 'ukraine.png');
    await instance.getWeather();
    // WeatherFactory wf = WeatherFactory(key);
    // Weather instance = await wf.currentWeatherByCityName(cityName);
    // print(instance);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'city': instance.city,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'tempMax': instance.tempMax,
      'tempMin': instance.tempMin,
      'humidity': instance.humidity,
      'iconId': instance.iconId,
      //'windSpeed': instance.windSpeed,
      'currentTime': instance.currentTime,
      'isDayTime': instance.isDayTime,
      'description': instance.description,
      'weatherList': instance.hoursWeatherList
    });
  }

  @override
  void initState() {
    super.initState();
    GetWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 220.0, 0, 0),
        child: Center(
          child: Column(
            children: [
              Text('Weather app',
                style: TextStyle(
                    fontSize: 60.0,
                    letterSpacing: 2.0,
                    color: Colors.black45,
                    fontFamily: 'IndieFlower'),
              ),
              SizedBox(height: 80),
              SpinKitCubeGrid(
                color: Colors.white,
                size: 60.0),
          Text('Weather app')
            ],
          ),
        ),
      ),
    );
  }
}
