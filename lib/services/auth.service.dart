
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lystui/models/serviceException.model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) throw new ServiceException("USER_NOT_CONNECTED");
    return user;
  }

  Future<FirebaseUser> signInUser(String email, String pass) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((_) => _auth.currentUser())
        .then((FirebaseUser user) {
      if (!user.isEmailVerified) {
        user.sendEmailVerification();
        signOutUser();
        throw new ServiceException("EMAIL_NOT_VERIFIED");
      }else
        return user;
    });
  }

  Future<void> signUpUser(String email, String pass) {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((_) => _auth.currentUser())
        .then((FirebaseUser user) => user.sendEmailVerification())
        .then((_) => _auth.signOut());
  }

  Future<void> signOutUser() async {
    return await _auth.signOut();
  }

  Future<void> resetUserPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}
