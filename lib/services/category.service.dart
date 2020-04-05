import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/serviceException.model.dart';

class CategoryService {
  final _storage = new FlutterSecureStorage();

  Future<List<Category>> getCategories() async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/category';
    Map<String, String> headers = {"Authorization": 'Bearer $authToken'};

    final response = await get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List body = jsonDecode(response.body);
        final categories = <Category>[];
        for (Map<String, dynamic> category in body)
          categories.add(Category.fromJson(category));
        return categories;
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<Category> createCategory(String title, int color) async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/category';
    Map<String, String> headers = {
      "Authorization": 'Bearer $authToken',
      "Content-type": "application/json"
    };
    String body = jsonEncode(Category(title: title, color: color));

    final response = await post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        Map body = jsonDecode(response.body);
        return Category.fromJson(body);
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }
}
