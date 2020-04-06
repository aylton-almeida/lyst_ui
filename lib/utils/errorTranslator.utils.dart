// Class to translate error codes in portuguese messages

abstract class ErrorTranslator {
  static String authError(error) {
    switch (error.code) {
      case "ERROR_USER_NOT_FOUND":
        return "Usuário não encontrado.";
      case "ERROR_WRONG_PASSWORD":
        return "Senha incorreta.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Muitas tentativas incorretas, tente novamente mais tarde.";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "Este email já está em uso.";
      case "EMAIL_NOT_VERIFIED":
        return "Email não verificado, um novo email de verificação foi enviado.";
      case "USER_NOT_CONNECTED":
        return "Usuário não conectado.";
      default:
        return "Ocorreu um erro, tente novamente mais tarde.";
    }
  }

  static String categoryError(error) {
    switch (error.code) {
      case "CATEGORY_NOT_FOUND":
        return "Categoria não encontrada";
      case "USER_NOT_CONNECTED":
        return "Usuário não conectado.";
      default:
        return "Ocorreu um erro, tente novamente mais tarde.";
    }
  }
}
