import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "Home",
        "pt_br": "Inicio",
      } +
      {
        "en_us": "Settings",
        "pt_br": "Configs",
      };
}
