
import 'package:flutter/material.dart';

class ThemeStyle {

  getBackground (isDark) {
    return
      BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark ?
              [Colors.indigo, Colors.indigoAccent] : [Colors.blue, Colors.indigo] )
      );
   }

  getFontColor (isDark) {
    return isDark ? Colors.white : Colors.white ;
  }

  getBottomNavigationBarColor (isDark) {
    return isDark ? Colors.indigo[700] : Colors.blue ;
  }

  getFloatingActionButtonColor (isDark) {
    return isDark ? Colors.indigo[700] : Colors.blue ;
  }

}