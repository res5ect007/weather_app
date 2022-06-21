import 'package:flutter/material.dart';
import 'language_preference.dart';

class LanguageModel extends ChangeNotifier {
  late String _language;
  late LanguagePreferences _preferences;
  String get language => _language;

  LanguageModel() {
    _language = 'En';
    _preferences = LanguagePreferences();
    getPreferences();
  }

  set language(String value) {
    _language = value;
    _preferences.setLanguage(value);
    notifyListeners();
  }

  getPreferences() async {
    _language = await _preferences.getLanguage();
    notifyListeners();
  }

}