import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<Weather> locations = [
    Weather(lat: '50.45', lon: '30.52', city: 'Kiev', flag: 'ukraine.png'),
    Weather(lat: '51.50', lon: '-0.12', city: 'London', flag: 'uk.png'),
    Weather(lat: '37.98', lon: '23.72', city: 'Athens', flag: 'greece.png'),
    Weather(lat: '30.06', lon: '31.24', city: 'Cairo', flag: 'egypt.png'),
    Weather(lat: '-1.28', lon: '36.81', city: 'Nairobi', flag: 'kenya.png'),
    Weather(lat: '-6.21', lon: '106.8', city: 'Jakarta', flag: 'indonesia.png'),
    Weather(lat: '40.71', lon: '-74.0', city: 'New York', flag: 'usa.png'),
    Weather(lat: '37.56', lon: '126.9', city: 'Seoul', flag: 'south_korea.png'),
  ];

  void updateWeather(index) async {

    Weather instance = locations[index];
    await instance.getWeather();

    Navigator.pop(context, {
      'lat': instance.lat,
      'lon': instance.lon,
      'flag': instance.flag,
      'city': instance.city,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'tempMax': instance.tempMax,
      'tempMin': instance.tempMin,
      'humidity': instance.humidity,
      'iconId': instance.iconId,
      //'windSpeed': result['windSpeed'],
      'currentTime': instance.currentTime,
      'isDayTime': instance.isDayTime,
      'description': instance.description,
      'weatherList': instance.hoursWeatherList
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Chose city'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateWeather(index);
                  },
                  title: Text(locations[index].city),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/flags/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
