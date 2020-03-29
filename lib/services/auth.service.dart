import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/models/user.model.dart';

class AuthService {
  final _storage = new FlutterSecureStorage();
  static User _user;

  Future<User> currentUser() async {
//    String authKey = await _storage.read(key: 'authKey');
//
//    if (authKey == null && _user == null) throw new ServiceException("USER_NOT_CONNECTED");
//    return user;
  }

  Future<User> signInUser(String email, String pass) {
//    return _auth
//        .signInWithEmailAndPassword(email: email, password: pass)
//        .then((_) => _auth.currentUser())
//        .then((FirebaseUser user) {
//      if (!user.isEmailVerified) {
//        user.sendEmailVerification();
//        signOutUser();
//        throw new ServiceException("EMAIL_NOT_VERIFIED");
//      } else
//        return user;
//    });
  }

  Future<void> signUpUser(String email, String pass) {
//    return _auth
//        .createUserWithEmailAndPassword(email: email, password: pass)
//        .then((_) => _auth.currentUser())
//        .then((FirebaseUser user) => user.sendEmailVerification())
//        .then((_) => _auth.signOut());
  }

  Future<void> signOutUser() async {
//    return await _auth.signOut();
  }

  Future<void> resetUserPassword(String email) async {
//    return await _auth.sendPasswordResetEmail(email: email);
  }
}
