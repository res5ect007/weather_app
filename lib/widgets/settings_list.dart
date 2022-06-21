
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/settings_icon_style.dart';

class SettingsItem extends StatelessWidget {
  IconData? icons;
  IconStyle? iconStyle;
  String? title;
  TextStyle? titleStyle;
  String? subtitle;
  TextStyle? subtitleStyle;
  Widget? trailing;
  VoidCallback onTap;

  SettingsItem(
      {Key? key, required this.icons,
        this.iconStyle,
        required this.title,
        this.titleStyle,
        this.subtitle = "",
        this.subtitleStyle,
        this.trailing,
        required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: (iconStyle != null && iconStyle!.withBackground!)
          ? Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(iconStyle!.borderRadius!),
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(
          icons,
         // size: SettingsScreenUtils.settingsGroupIconSize,
          color: Colors.white70,
        ),
      )
          : Icon(
        icons,
       // size: SettingsScreenUtils.settingsGroupIconSize,
      ),
      title: Text(
        title!,
        style: titleStyle ?? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text(
        subtitle!,
        style: subtitleStyle ?? const TextStyle(color: Colors.white70),
        maxLines: 1,
      ),
      trailing:
      (trailing != null) ? trailing : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70),

    );
  }
}

class LiteSettingsItem extends StatelessWidget {
  IconData? icons;
  IconStyle? iconStyle;
  String? title;
  TextStyle? titleStyle;
  Widget? trailing;
  VoidCallback onTap;

  LiteSettingsItem(
      {Key? key, required this.icons,
        this.iconStyle,
        required this.title,
        this.titleStyle,
        this.trailing,
        required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: (iconStyle != null && iconStyle!.withBackground!)
          ? Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(iconStyle!.borderRadius!),
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(
          icons,
          //size: SettingsScreenUtils.settingsGroupIconSize,
          color: Colors.white70,
        ),
      )
          : Icon(
        icons,
        //size: SettingsScreenUtils.settingsGroupIconSize,
      ),
      title: Text(
        title!,
        style: titleStyle ?? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      trailing:
      (trailing != null) ? trailing : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70),

    );
  }
}
