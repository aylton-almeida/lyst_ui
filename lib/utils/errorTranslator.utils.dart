// Class to translate error codes in portuguese messages
import 'package:i18n_extension/i18n_extension.dart';

extension _Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "User not found.",
        "pt_br": "Usuário não encontrado.",
      } +
      {
        "en_us": "An error occurred, please try again later.",
        "pt_br": "Ocorreu um erro, por favor tente novamente mais tarde.",
      } +
      {
        "en_us": "Wrong password.",
        "pt_br": "Senha incorreta.",
      } +
      {
        "en_us": "This email is already in use.",
        "pt_br": "Esse email já estã sendo usado.",
      } +
      {"en_us": "User not connected.", "pt_br": "Usuário não contectado."} +
      {"en_us": "Category not found.", "pt_br": "Categoria não encontrada"} +
      {"en_us": "Content", "pt_br": "Conteúdo"} +
      {"en_us": "Note not found.", "pt_br": "Nota não encontrada."};
}

abstract class ErrorTranslator {
  static String authError(error) {
    if (error.code == null)
      return "An error occurred, please try again later.".i18n;
    switch (error.code) {
      case "ERROR_USER_NOT_FOUND":
        return "User not found.".i18n;
      case "ERROR_WRONG_PASSWORD":
        return "Wrong password.".i18n;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "This email is already in use.".i18n;
      case "USER_NOT_CONNECTED":
        return "User not connected.".i18n;
      default:
        return "An error occurred, please try again later.".i18n;
    }
  }

  static String categoryError(error) {
    if (error.code == null)
      return "An error occurred, please try again later.".i18n;
    switch (error.code) {
      case "CATEGORY_NOT_FOUND":
        return "Category not found.".i18n;
      case "USER_NOT_CONNECTED":
        return "User not connected.".i18n;
      default:
        return "An error occurred, please try again later.".i18n;
    }
  }

  static String noteError(error) {
    if (error.code == null)
      return "An error occurred, please try again later.".i18n;
    switch (error.code) {
      case "NOTE_NOT_FOUND":
        return "Note not found.".i18n;
      case "USER_NOT_CONNECTED":
        return "User not connected.".i18n;
      default:
        return "An error occurred, please try again later.".i18n;
    }
  }
}
