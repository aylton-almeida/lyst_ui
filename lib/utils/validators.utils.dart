//Class containing text input validation functions

abstract class Validators {
  static String validateEmail(String value) {
    if (value.isEmpty) return 'Digite seu email.';
    final RegExp emailExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailExp.hasMatch(value)) return 'Endereço de email invalido.';
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) return 'Digite sua senha';
    if (value.length < 8) return 'Sua senha deve ter pelo menos 8 caracteres';
    return null;
  }

  static String validateConfPassword(String value, String pass) {
    if (value.isEmpty) return 'Digite a confirmação da senha';
    if (value != pass) return 'As senhas não coincidem';
    return null;
  }

  static String require(String value) {
    if (value == null) return 'Selecione uma opção';
    if (value.isEmpty) return 'Preencha o campo';
    return null;
  }
}
