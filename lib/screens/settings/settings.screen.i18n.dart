import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "Categories",
        "pt_br": "Categorias",
      } +
      {
        "en_us": "manage categories",
        "pt_br": "gerênciar categorias",
      } +
      {
        "en_us": "About us",
        "pt_br": "Sobre nós",
      } +
      {
        "en_us": "Logout",
        "pt_br": "Sair",
      };
}
