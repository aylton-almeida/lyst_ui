import 'dart:convert';

import 'package:lystui/utils/dateFormatter.utils.dart';

class Note {
  int id;
  String title;
  String content;
  int categoryId;
  int userId;
  int categoryColor;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    this.id,
    this.title,
    this.content,
    this.categoryId,
    this.userId,
    this.categoryColor,
    this.createdAt,
    this.updatedAt,
  });

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        categoryId = json['categoryId'],
        userId = json['userId'],
        categoryColor = json['Category.color'],
        createdAt = DateFormatter.formatJsonDateString(json['createdAt']),
        updatedAt = DateFormatter.formatJsonDateString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'categoryId': categoryId,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  @override
  String toString() => jsonEncode(this.toJson());
}
