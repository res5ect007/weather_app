import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/widgets/app_text.dart';
import 'package:weather_app/widgets/weather_container.dart';
import 'package:weather_app/widgets/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  {

  Map data = {};
  final Uri _url = Uri.parse('https://openweathermap.org');

  void _launchUrl() async {
      if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    Color? fontColor = Colors.white;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.indigo])),
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
              Weather instance = Weather(
                  city: prefs.getString('city') as String,
                  lat: prefs.getString('lat') as String,
                  lon: prefs.getString('lon') as String,
                  flag: prefs.getString('flag') as String);

              await instance.getWeather();
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
                    const Image(image: AssetImage('assets/icons/location.png'),
                    height: 25,
                    ),
                    const SizedBox(width: 10.0,),
                    AppText(text: data['city'], color: fontColor, size: 25.0,),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: AppText(
                      text: 'last update time ${data['currentTime']}',
                      color: fontColor,
                      size: 12.0),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                  AppText(text: data['temp'].toString(), color: fontColor, size: 85.0),
                    Column(
                      children: [
                        AppText(text: '℃', color: fontColor, size: 35.0),
                        const SizedBox(height: 30.0,)
                    ],),
                  const Spacer(),
                    OpacityAnimatedWidget.tween(
                        duration: const Duration(milliseconds: 1500),
                        child: WeatherIcon(iconId: data['iconId'], isDayTime: data['isDayTime'], height: 160, width: 160,))
                    ],
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AppText(text: data['description'], color: fontColor, size: 25.0),
                ),
                //SizedBox(height: 25.0,),
                Container(
                alignment: Alignment.bottomRight,
                child:
                Container(
                  height: 37,
                  width: 110.0,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.25)),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: TextButton.icon(onPressed: () {},
                    icon: Icon(Icons.umbrella,
                        size: 20.0
                        ,color: fontColor),
                    label: AppText(text: '${data['humidity']}%', color: fontColor, size: 14.0),
                  ),
                ),),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    Image.asset('assets/icons/temp_max.png',scale: 22,),
                    AppText(text: '${data['tempMax']}℃', color: fontColor, size: 15.0),
                    const SizedBox(width: 10.0),
                    Image.asset('assets/icons/temp_min.png',scale: 22,),
                    AppText(text: '${data['tempMin']}℃', color: fontColor, size: 15.0),
                    const Spacer(),
                    Container(
                      height: 37,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                      child: TextButton.icon(onPressed: () {},
                        icon: Icon(Icons.accessibility,
                            size: 18.0
                            ,color: fontColor),
                        label: AppText(text: '${data['feelsLike']}ºC', color: fontColor, size: 14.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                WeatherContainer(data: data['weatherList'], titleText: 'HOURLY WEATHER', isDayTime: data['isDayTime']),
                const SizedBox(height: 10.0),
                WeatherContainer(data: data['weatherDayList'], titleText: 'DAYS WEATHER', isDayTime: data['isDayTime']),
              ]),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color:Colors.blue,
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
                const SizedBox(width: 50,),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
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
  }
}
