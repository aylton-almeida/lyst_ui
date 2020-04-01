class Category {
  int id;
  String title;
  int color;
  int userId;
  DateTime createdDate;
  DateTime updateOn;

  Category(
      {this.id,
      this.title,
      this.color,
      this.createdDate,
      this.updateOn,
      this.userId});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        color = json['color'],
        userId = json['userId'],
        createdDate = json['createdDate'],
        updateOn = json['updateOn'];
}
