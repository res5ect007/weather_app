import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/theme_styles.dart';
import '../localization.dart';
import '../services/language_model.dart';
import '../services/theme_model.dart';
import 'package:sizer/sizer.dart';
import '../widgets/settings_icon_style.dart';
import '../widgets/settings_list.dart';
import '../widgets/settings_menu.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

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
                  settingsGroupTitle: KeepLocalization(locale: _language).settings,
                  settingsGroupTitleStyle: TextStyle(
                      color: themeStyle.getFontColor(themeNotifier.isDark), fontSize: 25.sp),
                  items: [
                    SettingsItem(
                      onTap: () {
                        Navigator.pushNamed(context, '/language');
                      },
                      icons: Icons.language,
                      iconStyle: IconStyle(),
                      title: KeepLocalization(locale: _language).languages,
                      subtitle: KeepLocalization(locale: _language).languageMenu,
                    ),
                    SettingsItem(
                      onTap: () {
                      },
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(),
                      title: themeNotifier.isDark ? KeepLocalization(locale: _language).darkMode : KeepLocalization(locale: _language).lightMode,
                      subtitle: KeepLocalization(locale: _language).automaticLanguage,
                      trailing: Switch.adaptive(
                        value: themeNotifier.isDark ? true : false,
                        onChanged: (value) {
                          themeNotifier.isDark
                              ? themeNotifier.isDark = false
                              : themeNotifier.isDark = true;
                        },
                      ),
                    ),
                    SettingsItem(
                      onTap: () {
                        Navigator.pushNamed(context, '/about');
                      },
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(),
                      title: KeepLocalization(locale: _language).aboutApp,
                      subtitle: KeepLocalization(locale: _language).aboutAppDetails,
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
