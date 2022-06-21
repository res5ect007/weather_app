import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/theme_styles.dart';
import 'package:weather_app/widgets/checkbox.dart';
import '../localization.dart';
import '../services/language_model.dart';
import '../services/theme_model.dart';
import '../widgets/settings_icon_style.dart';
import '../widgets/settings_list.dart';
import '../widgets/settings_menu.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {

  final ThemeStyle themeStyle = ThemeStyle();
  String _language = 'en';

  @override
  Widget build(BuildContext context) {

    _language = context.watch<LanguageModel>().language;

    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
    return Container(
      decoration: themeStyle.getBackground(themeNotifier.isDark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              // User card
              SettingsGroup(
                settingsGroupTitle: KeepLocalization(locale: _language).languages,
                settingsGroupTitleStyle: const TextStyle(color: Colors.white, fontSize: 30),
                items: [
                  LiteSettingsItem(
                    onTap: () {},
                    icons: Icons.language,
                    iconStyle: IconStyle(),
                    titleStyle: TextStyle(fontWeight: _language == 'en' ? FontWeight.bold : FontWeight.normal, color: Colors.white) ,
                    title: 'English',
                    trailing: const SettingsCheckBox(language: 'en'),
                  ),
                  LiteSettingsItem(
                    onTap: () {},
                    icons: Icons.language_outlined,
                    iconStyle: IconStyle(),
                    titleStyle: TextStyle(fontWeight: _language == 'uk' ? FontWeight.bold : FontWeight.normal, color: Colors.white) ,
                    title: 'Ukrainian',
                    trailing: const SettingsCheckBox(language: 'uk'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
        }
    );
  }
}

