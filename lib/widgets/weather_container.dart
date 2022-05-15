import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_icons.dart';
import 'package:sizer/sizer.dart';
import 'app_text.dart';

class WeatherContainer extends StatelessWidget {
  final String titleText;
  final List data;
  final bool isDayTime;

  const WeatherContainer({Key? key, required this.data, required this.titleText, required this.isDayTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      height: 18.h,
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
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
          SizedBox(
            height: 13.h,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(2.6.w, 0.9.h, 2.6.w, 0),
                  child: Column(
                    children: [
                      AppText(
                          text: data[index]['time'], size: 10.sp),
                      SizedBox(
                        height: 1.h,
                      ),
                      WeatherIcon(
                          iconId: data[index]['iconId'],
                          isDayTime: isDayTime),
                      SizedBox(
                        height: 1.h,
                      ),
                      AppText(
                          text: '${data[index]['temp']}°C',
                          size: 10.sp)
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
