import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Weather {
  String apiKey = '85810a93c46f0c45b6a19f56f9dcb2ad';
  String units = 'metric';
  String city;
  late String country;
  late dynamic temp;
  late dynamic feelsLike;
  late dynamic humidity;
  late dynamic tempMin;
  late dynamic tempMax;
  late String iconId;
  late double windSpeed;
  late String currentTime;
  late bool isDayTime;
  List hoursWeatherList = [];
  late String description;
  String lat;
  String lon;
  String flag;

  Weather({required this.city, required this.lat, required this.lon, required this.flag});

  Future<void> getWeather() async {
    print('ok1');
    try {
      //make the request
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&cnt=10&units=$units&appid=$apiKey'));
      Map data = jsonDecode(response.body);

      Response currentResponse = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=$units&appid=$apiKey'));
      Map currentData = jsonDecode(currentResponse.body);

      //get properties
      temp = currentData['main']['temp'];
      feelsLike = currentData['main']['feels_like'];
      humidity = currentData['main']['humidity'];
      temp = temp.round();
      humidity = humidity.round();
      feelsLike = feelsLike.round();
      tempMin = currentData['main']['temp_min'];
      tempMax = currentData['main']['temp_max'];
      tempMin = tempMin.round();
      tempMax = tempMax.round();
      iconId = currentData['weather'][0]['icon'];
      //windSpeed = currentData['wind']['speed'];
      description = currentData['weather'][0]['description'];

      // set time property
      DateTime now = DateTime.now();
      currentTime = DateFormat.Hm().format(now);
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;

      for (int i = 0; i < data['list'].length; i++){

       // DateTime hoursTime = DateTime.fromMillisecondsSinceEpoch(data['hourly'][i]['dt']);
        DateTime hoursTime = DateTime.parse(data['list'][i]['dt_txt']);
        dynamic hoursTemp = data['list'][i]['main']['temp'];
        hoursTemp = hoursTemp.round();

        var listValue = {
            'time': DateFormat.Hm().format(hoursTime),
            'temp': hoursTemp,
            'iconId': data['list'][i]['weather'][0]['icon'],
          };
        hoursWeatherList.add(listValue);
      }

      //return this;
      print('ok2');

    } catch (e) {
      print('sorry, error');
    }
  }
}