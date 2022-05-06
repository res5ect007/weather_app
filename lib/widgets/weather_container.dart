
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_icons.dart';

import 'app_text.dart';

class WeatherContainer extends StatelessWidget {
  String titleText;
  List data;
  bool isDayTime;

  WeatherContainer({Key? key, required this.data, required this.titleText, required this.isDayTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                titleText,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
                  child: Column(
                    children: [
                      AppText(
                          text: data[index]['time'], size: 13.0),
                      SizedBox(
                        height: 10.0,
                      ),
                      WeatherIcon(
                          iconId: data[index]['iconId'],
                          isDayTime: isDayTime),
                      SizedBox(
                        height: 10.0,
                      ),
                      AppText(
                          text: '${data[index]['temp']}°C',
                          size: 13.0)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
