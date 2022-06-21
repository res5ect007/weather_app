import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/widgets/app_text.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/theme_styles.dart';
import '../localization.dart';
import '../services/language_model.dart';
import '../services/theme_model.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  final ThemeStyle themeStyle = ThemeStyle();
  String _language = 'en';

  List<Weather> locations = [
    Weather(lat: '', lon: '', city: 'Current position', flag: 'geolocation.png', currentPosition: true),
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
    await instance.getWeather(_language);

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
      'windSpeed': instance.windSpeed,
      'currentTime': instance.currentTime,
      'isDayTime': instance.isDayTime,
      'description': instance.description,
      'weatherList': instance.hoursWeatherList,
      'daysWeatherList': instance.daysWeatherList
    });
  }

  @override
  Widget build(BuildContext context) {

    _language = context.watch<LanguageModel>().language;

    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: themeStyle.getBackground(themeNotifier.isDark),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
            padding: EdgeInsets.fromLTRB(5.w, 2.h, 0, 2.w),
            child: AppText(text: KeepLocalization(locale: _language).locations, size: 20.sp)
          ),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      return
                        ListTile(
                              onTap: () {
                                updateWeather(index);
                              },
                              title: AppText(text: locations[index].city, size: 12.sp,),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage('assets/flags/${locations[index].flag}'),
                              ),
                        );
                    }, separatorBuilder: (BuildContext context, int index) => const Divider(),),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: () {  },
        backgroundColor: themeStyle.getFloatingActionButtonColor(themeNotifier.isDark),
            child: const Icon(Icons.add)),
      );
    });
  }
}


