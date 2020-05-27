import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "sign in",
        "pt_br": 'entrar',
      } +
      {
        "en_us": "sign up",
        "pt_br": 'cadastrar',
      } +
      {"en_us": 'Type your email...', "pt_br": 'Digite seu email...'} +
      {"en_us": 'Password', "pt_br": 'Senha'} +
      {"en_us": 'Type your password...', "pt_br": 'Digite sua senha...'} +
      {"en_us": 'connect', "pt_br": 'conectar'} +
      {"en_us": 'Forgot your password?', "pt_br": 'Esqueceu sua senha?'} +
      {"en_us": 'Confirm password...', "pt_br": 'Confirme sua senha...'};
}
