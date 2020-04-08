import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/services/category.service.dart';

class CategoryProvider with ChangeNotifier {
  final _service = CategoryService();
  List<Category> categories = [];
  Category currentCategory;

  Future<void> doUpdateCategories() async {
    this.categories = await _service.getCategories();
    notifyListeners();
  }

  Future<void> doCreateCategory(String title, int color) async {
    this.categories = [
      await _service.createCategory(title, color),
      ...this.categories
    ];
    notifyListeners();
  }

  Future<void> doUpdateCategory(int id, String title, int color) async {
    await _service.updateCategory(id, title, color);
    final category =
        this.categories.firstWhere((category) => category.id == id);
    this.categories.remove(category);
    category.title = title;
    category.color = color;
    this.categories = [category, ...this.categories];
    notifyListeners();
  }

  Future<void> doDeleteCategory(int id) async {
    await _service.deleteCategory(id);
    this.categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }

  void setCurrentCategory(Category category) => this.currentCategory = category;
}
