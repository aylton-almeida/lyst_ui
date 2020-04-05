import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/services/category.service.dart';

class CategoryProvider with ChangeNotifier {
  CategoryService _service = CategoryService();
  List<Category> categories = [];

  Future<void> doUpdateCategories() async {
    this.categories = await _service.getCategories();
    notifyListeners();
  }

  Future<void> doCreateCategory(String title, int color) async {
    this.categories.add(await _service.createCategory(title, color));
    notifyListeners();
  }
}
