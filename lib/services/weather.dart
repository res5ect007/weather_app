import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/geolocation.dart';

class Weather {
  final String apiKey = '85810a93c46f0c45b6a19f56f9dcb2ad';
  String units = 'metric';
  late String country;
  late dynamic temp;
  late dynamic feelsLike;
  late dynamic humidity;
  late dynamic tempMin;
  late dynamic tempMax;
  late int iconId;
  late double windSpeed;
  late String currentTime;
  late bool isDayTime;
  List hoursWeatherList = [];
  List daysWeatherList = [];
  late String description;
  String city;
  String lat;
  String lon;
  String flag;
  bool currentPosition;


  Weather({required this.city, required this.lat, required this.lon, required this.flag, this.currentPosition = false});

  Future<void> getWeather() async {
    print('ok1');
    try {

      if (currentPosition) {
        Location location = Location();
        Position position =  await location.determinePosition();
        lat = position.latitude.toString();
        lon = position.longitude.toString();
      }

      //make the request for hours
      Response response = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&cnt=10&units=$units&appid=$apiKey'));
      Map data = jsonDecode(response.body);

      Response dayResponse = await get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly&units=$units&appid=$apiKey'));
      Map daysData = jsonDecode(dayResponse.body);

      //get properties
      city = data['city']['name'];
      temp = daysData['current']['temp'];
      feelsLike = daysData['current']['feels_like'];
      humidity = daysData['current']['humidity'];
      temp = temp.round();
      humidity = humidity.round();
      feelsLike = feelsLike.round();
      iconId = daysData['current']['weather'][0]['id'];
      windSpeed = daysData['current']['wind_speed'];
      description = daysData['current']['weather'][0]['description'];

      String capitalize(String name) => '${name[0].toUpperCase()}${name.substring(1)}';
      description = capitalize(description);

      // set time property
      DateTime now = DateTime.now();
      currentTime = DateFormat.Hm().format(now);
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;

      for (int i = 0; i < data['list'].length; i++){

        DateTime hoursTime = DateTime.fromMillisecondsSinceEpoch(data['list'][i]['dt'] * 1000);
        dynamic hoursTemp = data['list'][i]['main']['temp'];

        var listValue = {
            'time': DateFormat.Hm().format(hoursTime),
            'temp': hoursTemp.round(),
            'iconId': data['list'][i]['weather'][0]['id'],
          };
        hoursWeatherList.add(listValue);
      }

      for (int i = 0; i < daysData['daily'].length; i++){

        DateTime daysTime = DateTime.fromMillisecondsSinceEpoch(daysData['daily'][i]['dt'] * 1000);
        dynamic daysTemp = daysData['daily'][i]['temp']['day'];

        if (i == 0) {
          tempMin = daysData['daily'][i]['temp']['min'];
          tempMax = daysData['daily'][i]['temp']['max'];
          tempMin = tempMin.round();
          tempMax = tempMax.round();
        }

        var listValue = {
          'time': i == 0 ? 'Today' : DateFormat.MMMd().format(daysTime),
          'temp': daysTemp.round(),
          'iconId': daysData['daily'][i]['weather'][0]['id'],
        };
        daysWeatherList.add(listValue);
      }

      print('ok2');

    } catch (e) {
      print('sorry, error');
    }
  }
}