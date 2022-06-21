import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_model.dart';

class SettingsCheckBox extends StatefulWidget {
  final String language;

  const SettingsCheckBox({Key? key, required this.language}) : super(key: key);

  @override
  State<SettingsCheckBox> createState() => _SettingsCheckBoxState();
}

class _SettingsCheckBoxState extends State<SettingsCheckBox> {
  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.amber;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: context.watch<LanguageModel>().language == widget.language,
      onChanged: (newValue) {
        context.read<LanguageModel>().language = widget.language;
      },
    );
  }
}
