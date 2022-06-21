import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/widgets/app_text.dart';
import 'package:weather_app/widgets/weather_container.dart';
import 'package:weather_app/widgets/weather_icons.dart';
import 'package:weather_app/services/theme_styles.dart';
import '../localization.dart';
import '../services/language_model.dart';
import '../services/theme_model.dart';
import 'package:sizer/sizer.dart';

import '../widgets/weather_details_container.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {

  Map data = {};
  final Uri _url = Uri.parse('https://openweathermap.org');
  final ThemeStyle themeStyle = ThemeStyle();
  String _language = 'en';
  Weather instance =  Weather(lat: '', lon: '', city: 'Current position', flag: 'geolocation.png', currentPosition: true);

  void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {


    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    _language = context.watch<LanguageModel>().language;

    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
      return Container(
        decoration: themeStyle.getBackground(themeNotifier.isDark),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   title: TextButton.icon(onPressed: () async {
            //   },
            //     icon: Icon(Icons.location_on, size: 25.0, color: fontColor),
            //   label: Text(''),
            //   ),
            // ),
            // endDrawer: Drawer(
            //   backgroundColor: Colors.transparent,
            //   child: ListView(
            //     children: [
            //       DrawerHeader(
            //           decoration: BoxDecoration(color: Colors.blue, ),
            //           child: Center(
            //               child:
            //           Row(
            //             children: [
            //               Container(
            //                 height: 120,
            //                 width: 120,
            //                 child: const CircleAvatar(
            //                     child: Image(
            //                         image: AssetImage('assets/icons/weather_app.png'))),
            //               ),
            //               Column(
            //                 children: [
            //                   AppText(text: 'Weather app',font: 'IndieFlower', size: 26,),
            //                   AppText(text: 'ver. 1.1.0',font: 'IndieFlower', size: 26,),
            //                 ],
            //               ),
            //             ],
            //           ))),
            //       ListTile(shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white, width: 1), borderRadius: BorderRadius.circular(10)),
            //         focusColor: Colors.blueGrey,
            //         style: ListTileStyle.list,
            //         autofocus: true,
            //         contentPadding: EdgeInsets.all(8.0),
            //         textColor: Colors.white,
            //         title: Text('Settings'),
            //       )
            //     ],
            //   ),
            // ),
            body: RefreshIndicator(
              onRefresh: () async {

                await Future.delayed(const Duration(seconds: 0));

                final prefs = await SharedPreferences.getInstance();

                if (prefs.containsKey('city')) {
                Weather instance = Weather(
                    city: prefs.getString('city') as String,
                    lat: prefs.getString('lat') as String,
                    lon: prefs.getString('lon') as String,
                    flag: prefs.getString('flag') as String);
                }

                await instance.getWeather(_language);

                setState(() {
                  data = {
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
                  };
              });
                },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(children: [
                  Row(
                    children: [
                      Image(image: const AssetImage('assets/icons/location.png'),
                      height: 3.h,
                      ),
                      SizedBox(width: 3.w),
                      AppText(text: data['city'], size: 23.sp, translate: true,),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                        text: '${KeepLocalization(locale: _language).updateText} ${data['currentTime']}',
                        size: 10.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                    AppText(text: data['temp'].toString(), size: 80.sp),
                      Column(
                        children: [
                          AppText(text: '℃', size: 35.sp),
                          SizedBox(height: 6.h,)
                      ],
                      ),
                    const Spacer(),
                      OpacityAnimatedWidget.tween(
                          duration: const Duration(milliseconds: 1500),
                          child: WeatherIcon(iconId: data['iconId'], isDayTime: data['isDayTime'], height: 20.h, width: 40.w,))
                      ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 5.w),
                    child: AppText(text: data['description'], size: 25.sp),
                  ),
                  Container(
                  alignment: Alignment.bottomRight,
                  child: WeatherDetailsContainer(text: '${data['humidity']}%', icon: Icons.umbrella)),
                  SizedBox(height: 0.5.h,),
                  Row(
                    children: [
                      Image.asset('assets/icons/temp_max.png',scale: 22,),
                      AppText(text: '${data['tempMax']}℃', size: 13.sp),
                      const SizedBox(width: 10.0),
                      Image.asset('assets/icons/temp_min.png',scale: 22,),
                      AppText(text: '${data['tempMin']}℃', size: 13.sp),
                      const Spacer(),
                      WeatherDetailsContainer(text: '${data['feelsLike']}ºC', icon: Icons.accessibility)
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  WeatherContainer(data: data['weatherList'], titleText: KeepLocalization(locale: _language).hourlyWeather, isDayTime: data['isDayTime']),
                  const SizedBox(height: 10.0),
                  WeatherContainer(data: data['weatherDayList'], titleText: KeepLocalization(locale: _language).daysWeather, isDayTime: data['isDayTime']),
                ]),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: themeStyle.getBottomNavigationBarColor(themeNotifier.isDark),
              shape: const CircularNotchedRectangle(),
              notchMargin: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.web_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _launchUrl();
                    },
                  ),
                  SizedBox(width: 20.w),
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/settings');
                      setState(() {});
                    }
                   ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: themeStyle.getFloatingActionButtonColor(themeNotifier.isDark),
              onPressed: () async {
                dynamic result = await Navigator.pushNamed(context, '/location');
                setState(() {
                  data = {
                    'city': result['city'],
                    'temp': result['temp'],
                    'feelsLike': result['feelsLike'],
                    'tempMax': result['tempMax'],
                    'tempMin': result['tempMin'],
                    'humidity': result['humidity'],
                    'iconId': result['iconId'],
                    'windSpeed': result['windSpeed'],
                    'currentTime': result['currentTime'],
                    'isDayTime': result['isDayTime'],
                    'description': result['description'],
                    'weatherList': result['weatherList'],
                    'weatherDayList': result['daysWeatherList']
                  };
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('city', result['city']);
                await prefs.setString('lat', result['lat']);
                await prefs.setString('lon', result['lon']);
                await prefs.setString('flag', result['flag']);
              },
              child: const Icon(Icons.location_on),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        ),
      );
      },
    );
  }
}
