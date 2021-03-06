import 'package:flutter/material.dart';

/// This component group the Settings items (BabsComponentSettingsItem)
/// All one BabsComponentSettingsGroup have a title and the developper can improve the design.
class SettingsGroup extends StatelessWidget {
  String? settingsGroupTitle;
  TextStyle? settingsGroupTitleStyle;
  List<dynamic> items;
  // Icons size
  double? iconItemSize;

  SettingsGroup(
      {Key? key, this.settingsGroupTitle,
        this.settingsGroupTitleStyle,
        required this.items,
        this.iconItemSize = 25}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (iconItemSize != null) {
    //   SettingsScreenUtils.settingsGroupIconSize = iconItemSize;
    // }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The title
          (settingsGroupTitle != null)
              ? Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              settingsGroupTitle!,
              style: (settingsGroupTitleStyle == null)
                  ? const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                  : settingsGroupTitleStyle,
            ),
          )
              : Container(),
          // The SettingsGroup sections
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              },
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
