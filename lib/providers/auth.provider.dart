import 'package:flutter/material.dart';
import 'package:lystui/models/user.model.dart';
import 'package:lystui/services/auth.service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _service = AuthService();
  User user;

  AuthProvider({user}) : this.user = user;

  Future<User> currentUser() async {
    this.user = await _service.currentUser();
    notifyListeners();
    return this.user;
  }

  Future<void> doSignInUser(String email, String pass) async {
    user = await _service.signInUser(email, pass);
    notifyListeners();
  }

  Future<void> doSignUpUser(String email, String pass) async {
    user = await _service.signUpUser(email, pass);
    notifyListeners();
  }

  Future<void> doSignOutUser() async {
    await _service.signOutUser();
    user = null;
    notifyListeners();
  }

  Future<void> doResetUserPassword(String email) =>
      _service.resetUserPassword(email);
}
