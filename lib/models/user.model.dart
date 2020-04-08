import 'dart:convert';

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
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  @override
  String toString() => jsonEncode(this.toJson());
}
