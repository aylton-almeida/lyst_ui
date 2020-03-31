import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/models/user.model.dart';

class AuthService {
  final _storage = new FlutterSecureStorage();
  String _authToken;

  Future<User> currentUser() async {
    this._authToken = await _storage.read(key: 'authToken');

    print(this._authToken);

    if (this._authToken == null)
      throw new ServiceException(code: "USER_NOT_CONNECTED");

    String url = '${DotEnv().env['BACKEND_URL']}/validateToken';
    print(url);
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = jsonEncode({"token": this._authToken});

    Response response = await post(url, headers: headers, body: body);

    print(response.body);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);
        final user = User.fromJson(body['user']);
        await _storage.write(key: 'authToken', value: _authToken);
        return user;
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      default:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
    }
  }

  Future<User> signInUser(String email, String pass) async {
    String url = '${DotEnv().env['BACKEND_URL']}/auth';
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = jsonEncode(User(email: email, password: pass));

    Response response = await post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);
        final user = User.fromJson(body['user']);
        this._authToken = body['token'];
        await _storage.write(key: 'authToken', value: _authToken);
        return user;
      case 400:
        print(response.body);
        throw new ServiceException(code: 'ERROR_WRONG_PASSWORD');
      case 404:
        print(response.body);
        throw new ServiceException(code: 'ERROR_USER_NOT_FOUND');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<User> signUpUser(String email, String pass) async {
    String url = '${DotEnv().env['BACKEND_URL']}/user';
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = jsonEncode(User(email: email, password: pass));

    Response response = await post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);
        final newUser = User.fromJson(body['user']);
        this._authToken = body['token'];
        await _storage.write(key: 'authToken', value: _authToken);
        return newUser;
      case 422:
        print(response.body);
        throw new ServiceException(code: 'ERROR_EMAIL_ALREADY_IN_USE');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<void> signOutUser() async {
//    return await _auth.signOut();
  }

  Future<void> resetUserPassword(String email) async {
//    return await _auth.sendPasswordResetEmail(email: email);
  }
}
