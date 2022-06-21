import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const language = 'language';

  setLanguage(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(language, value);
  }

  getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(language) ?? 'en';
  }
}