import 'package:flutter/cupertino.dart';
import 'package:lystui/models/user.model.dart';
import 'package:lystui/services/auth.service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _service = AuthService();
  User _user;

  AuthProvider({user}) : this._user = user;

  Future<User> currentUser() async {
    this._user = await _service.currentUser();
    notifyListeners();
    return this._user;
  }

  Future<void> doSignInUser(String email, String pass) async {
    _user = await _service.signInUser(email, pass);
    notifyListeners();
  }

  Future<void> doSignUpUser(String email, String pass) async {
    _user = await _service.signUpUser(email, pass);
    notifyListeners();
  }

  Future<void> doSignOutUser() async {
    await _service.signOutUser();
    _user = null;
    notifyListeners();
  }

  Future<void> doResetUserPassword(String email) =>
      _service.resetUserPassword(email);
}
