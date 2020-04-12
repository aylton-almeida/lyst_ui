import 'dart:convert';

import 'package:lystui/utils/dateFormatter.utils.dart';

class Category {
  int id;
  String title;
  int color;
  int userId;
  int notesCount;
  DateTime createdAt;
  DateTime updatedAt;

  Category(
      {this.id,
      this.title,
      this.color,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.notesCount});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        color = json['color'],
        userId = json['userId'],
        notesCount =
            json['notesCount'] != null ? int.parse(json['notesCount']) : 0,
        createdAt = DateFormatter.formatJsonDateString(json['createdAt']),
        updatedAt = DateFormatter.formatJsonDateString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'color': color,
        'userId': userId,
        'createdAt': createdAt,
        'updateAt': updatedAt,
      };

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
