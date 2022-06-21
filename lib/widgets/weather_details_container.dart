import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app_text.dart';

class WeatherDetailsContainer extends StatelessWidget {
  final String text;
  final IconData icon;

  const WeatherDetailsContainer(
      {Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.6.h,
      width: 31.w,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          border: Border.all(color: Colors.grey.withOpacity(0.25)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white70, size: 20.0),
        label: AppText(text: text, size: 11.sp),
      ),
    );
  }
}
