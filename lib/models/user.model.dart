import 'dart:convert';

import 'package:lystui/utils/dateFormatter.utils.dart';

class User {
  int id;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  User({this.id, this.email, this.password, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'],
        createdAt = DateFormatter.formatJsonDateString(json['createdAt']),
        updatedAt = DateFormatter.formatJsonDateString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  @override
  String toString() => jsonEncode(this.toJson());
}
