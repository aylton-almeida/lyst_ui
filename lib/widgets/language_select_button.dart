import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

class LanguageSelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: I18n.locale.toString(),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      dropdownColor: Color(0xFF000002),
      onChanged: (newValue) => I18n.of(context).locale = newValue.length > 2
          ? Locale(newValue.substring(0, 2), newValue.substring(3))
          : Locale(newValue),
      items: {
        'en_US': 'English',
        'pt_BR': 'Português',
      }
          .map(
            (key, value) => MapEntry(
              key,
              DropdownMenuItem<String>(
                value: key,
                child: Text(value),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
