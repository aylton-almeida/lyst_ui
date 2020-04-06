import 'dart:convert';

class User {
  int id;
  String email;
  String password;
  DateTime createdDate;
  DateTime updateOn;

  User(
      {this.id,
      this.email,
      this.password,
      this.createdDate,
      this.updateOn});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'],
        createdDate = json['createdDate'],
        updateOn = json['updateOn'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'createdDate': createdDate,
        'updateOn': updateOn,
      };

  @override
  String toString() => jsonEncode(this.toJson());
}
