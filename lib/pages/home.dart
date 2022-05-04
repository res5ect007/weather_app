import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    Color? fontColor = Colors.white;
    String bgImage = data['isDayTime'] ? 'day' : 'night';
    Color? bgColor = data['isDayTime'] ? Colors.lightBlue[400] : Colors.indigo[800];
    String fontFamily = 'Nunito';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage.png'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(data['city'],
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 40.0,
                          fontFamily: fontFamily)),
                      Spacer(),
                      IconButton(
                          alignment: Alignment.bottomRight,
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
                                //'windSpeed': result['windSpeed'],
                                'currentTime': result['currentTime'],
                                'isDayTime': result['isDayTime'],
                                'description': result['description'],
                                'weatherList': result['weatherList']
                              };
                            });
                          },
                          icon: Icon(
                              Icons.location_on,
                              size: 25.0,
                              color: fontColor)),
                      IconButton(
                          alignment: Alignment.bottomRight,
                          onPressed: () async {

                            Weather instance = Weather(city: 'Lviv', lat: '50.45', lon: '30.52', flag: 'ukraine.png');
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
                                //'windSpeed': instance.windSpeed,
                                'currentTime': instance.currentTime,
                                'isDayTime': instance.isDayTime,
                                'description': instance.description,
                                'weatherList': instance.hoursWeatherList
                              };
                            });
                          },
                          icon: Icon(
                              Icons.update,
                              size: 25.0,
                              color: fontColor))
                    ],
                  ),
                  Text('last update time ${data['currentTime']}',
                      style: TextStyle(
                          color: fontColor,
                          fontSize: 15.0,
                          fontFamily: fontFamily),),
                ],
              ),
              SizedBox(height: 150.0),
              Row(
                children: [
                Column(
                  children: [
                      Text(data['temp'].toString(),
                          style: TextStyle(
                              color: fontColor,
                              fontSize: 75.0,
                              fontFamily: fontFamily)
                      )
                    ],
                ),
                Column(
                  children: [
                    Text('℃',
                      style: TextStyle(color: fontColor,
                          fontSize: 35.0,
                          fontFamily: fontFamily),),
                    SizedBox(height: 30.0,)
                  ],
                ),
                Image.network('http://openweathermap.org/img/wn/${data['iconId']}@2x.png',fit: BoxFit.cover),
                Column(
                  children: [
                    SizedBox(height: 25.0,),
                    Row(
                      children: [
                        Column(
                          children: [
                            Wrap(
                              children: [
                                Icon(Icons.arrow_upward, color: Colors.white,  size: 18),
                                Text('${data['tempMin']}℃',
                                    style: TextStyle(
                                        color: fontColor,
                                        fontSize: 16.0,
                                        fontFamily: fontFamily)
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Wrap(
                              children: [
                                Icon(Icons.arrow_downward, color: Colors.white, size: 18),
                                Text('${data['tempMin']}℃',
                                    style: TextStyle(
                                        color: fontColor,
                                        fontSize: 16.0,
                                        fontFamily: fontFamily)
                                ),
                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                        height: 37,
                        width: 110.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.25),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.25)),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: TextButton.icon(onPressed: () {},
                          icon: Icon(Icons.umbrella,
                              size: 20.0
                              ,color: fontColor),
                          label: Text('${data['humidity']}%',style: TextStyle(
                              color: fontColor,
                              fontSize: 18.0,
                              fontFamily: fontFamily) ,)),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 37,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      child: TextButton.icon(onPressed: () {},
                          icon: Icon(Icons.accessibility,
                              size: 18.0
                              ,color: fontColor),
                          label: Text('${data['feelsLike']}ºC',style: TextStyle(
                              color: fontColor,
                              fontSize: 18.0,
                              fontFamily: fontFamily) ,)),
                    ),
                  ],),],
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 15.0),
                child: Text(data['description'],
                    style: TextStyle(
                        color: fontColor,
                        fontSize: 25.0,
                        fontFamily: fontFamily,
                    )),
              ),
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.bottomLeft,
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Text('hourly weather', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w100
                    ),textAlign: TextAlign.start),
                    Container(
                      height: 125.0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data['weatherList'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              child: Column(
                                children: [
                                  Text(data['weatherList'][index]['time']),
                                  Image.network('http://openweathermap.org/img/wn/${data['weatherList'][index]['iconId']}@2x.png',
                                  height: 60.0,
                                  width: 60.0,),
                                  Text('${data['weatherList'][index]['temp']}°C'),
                                ],
                              ),
                            );
                          },
                    ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
