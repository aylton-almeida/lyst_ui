// Class to translate error codes in portuguese messages

abstract class ErrorTranslator {
  static String authError(error) {
    if (error.code == null)
      return "An error happened, please try again later.";
    switch (error.code) {
      case "ERROR_USER_NOT_FOUND":
        return "User not found.";
      case "ERROR_WRONG_PASSWORD":
        return "Wrong password.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many atempts, please try again later.";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "This email is already in use.";
      case "EMAIL_NOT_VERIFIED":
        return "Email not vertified, a new verification email was sent.";
      case "USER_NOT_CONNECTED":
        return "User not connected.";
      default:
        return "An error happened, please try again later.";
    }
  }

  static String categoryError(error) {
    if (error.code == null)
      return "An error happened, please try again later.";
    switch (error.code) {
      case "CATEGORY_NOT_FOUND":
        return "Category not found.";
      case "USER_NOT_CONNECTED":
        return "User not connected.";
      default:
        return "An error happened, please try again later.";
    }
  }

  static String noteError(error) {
    if (error.code == null)
      return "An error happened, please try again later.";
    switch (error.code) {
      case "NOTE_NOT_FOUND":
        return "Note not found.";
      case "USER_NOT_CONNECTED":
        return "User not connected.";
      default:
        return "An error happened, please try again later.";
    }
  }
}
