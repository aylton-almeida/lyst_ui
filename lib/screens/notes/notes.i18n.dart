import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "Not Cateogorized",
        "pt_br": "Não Categorizado",
      } +
      {
        "en_us": "An error occurred, please try again later",
        "pt_br": "Ocorreu um erro, por favor tente novamente mais tarde",
      } +
      {
        "en_us": "Empty note",
        "pt_br": "Nota vazia",
      } +
      {
        "en_us": "All Notes",
        "pt_br": "Todas as notas",
      } +
      {
        "en_us": "Note deleted with success",
        "pt_br": "Notas deletas com sucesso"
      } +
      {"en_us": "Note Title", "pt_br": "Titulo da nota"} +
      {"en_us": "Content", "pt_br": "Conteúdo"} +
      {"en_us": "Search for...", "pt_br": "Procurar por..."} +
      {"en_us": "Not Categorized", "pt_br": "Não Categorizado"};
}
