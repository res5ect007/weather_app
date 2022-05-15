import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {

  final int iconId;
  final double height;
  final double width;
  final bool isDayTime;

  const WeatherIcon({Key? key, required this.iconId, required this.isDayTime, this.height = 30, this.width = 30}): super(key: key);

  @override
  Widget build(BuildContext context) {
    Image weatherIcon = getWeatherImage(iconId, isDayTime);
    return Image(width: width,
        height: height,
        image: weatherIcon.image);
  }

  static Image getWeatherImage(iconId, isDayTime) {

    if ((iconId >= 200) & (iconId < 300)) {
      if (isDayTime) {return const Image(
            image: AssetImage('assets/icons/thunderstorm_day.png'));
      } else {return const Image(
            image: AssetImage('assets/icons/thunderstorm_night.png'));
      }
    }
    else if((iconId>=300) & (iconId<500)){
      return const Image(image: AssetImage('assets/icons/shower_rain.png'));
    }
    else if((iconId>=500) & (iconId<=504)){
      if (isDayTime) {return const Image(
          image: AssetImage('assets/icons/rain_day.png'));
      } else {return const Image(
          image: AssetImage('assets/icons/rain_nighy.png'));
      }
    }
    else if(iconId==511){
      return const Image(image: AssetImage('assets/icons/snow.png'));
    }
    else if ((iconId >= 520) & (iconId <= 531)) {
      return const Image(image: AssetImage('assets/icons/shower_rain.png'));
    }
    else if((iconId>=600) & (iconId<700)){
      return const Image(image: AssetImage('assets/icons/snow.png'));
    }
    else if((iconId>=700) & (iconId<800)){
      return const Image(image: AssetImage('assets/icons/mist.png'));
    }
    else if(iconId==800){
      if (isDayTime) {return const Image(
          image: AssetImage('assets/icons/clea_sky_day.png'));
      } else {return const Image(
          image: AssetImage('assets/icons/clea_sky_night.png'));
      }
    }
    else if(iconId==801){
      if (isDayTime) {return const Image(
          image: AssetImage('assets/icons/few_clouds_day.png'));
      } else {return const Image(
          image: AssetImage('assets/icons/few_clouds_night.png'));
      }
    }
    else if(iconId==802){
      return const Image(image: AssetImage('assets/icons/scattered_clouds.png'));
    }
    else if((iconId==803) || (iconId==804)){
      return const Image(image: AssetImage('assets/icons/broken_clouds.png'));
    }
    else{
      return const Image(image: AssetImage('assets/icons/star.png'));
    }
  }
}
