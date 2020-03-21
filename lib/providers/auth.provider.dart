import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lystui/services/auth.service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _service = AuthService();
  FirebaseUser _user;

  AuthProvider({user}) : this._user = user;

  Future<FirebaseUser> doUpdateUser() async {
    _service.currentUser()
    .then((user) => this._user = user)
    .catchError((err) {
      print(err);
      return this._user = null;
    });
    notifyListeners();
    return this._user;
  }

  Future<void> doSignInUser(String email, String pass) async {
    _user = await _service.signInUser(email, pass);
    notifyListeners();
  }

  Future<void> doSignUpUser(String email, String pass) async {
    await _service.signUpUser(email, pass);
    notifyListeners();
  }

  Future<void> doSignOutUser() async {
    await _service.signOutUser();
    _user = null;
    notifyListeners();
  }

  Future<void> doResetUserPassword(String email)=> _service.resetUserPassword(email);
}
