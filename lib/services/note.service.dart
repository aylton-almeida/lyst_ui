import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/models/serviceException.model.dart';

class NoteService {
  final _storage = new FlutterSecureStorage();

  Future<List<Note>> getCategoryNotes(int categoryId) async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/categoryNotes';
    Map<String, String> headers = {
      "Authorization": 'Bearer $authToken',
      "Content-type": "application/json"
    };
    String body = jsonEncode({'categoryId': categoryId});

    final response = await post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        List body = jsonDecode(response.body);
        final notes = <Note>[];
        for (Map<String, dynamic> note in body) notes.add(Note.fromJson(note));
        return notes;
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<List<Note>> getAllNotes() async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/note';
    Map<String, String> headers = {"Authorization": 'Bearer $authToken'};

    final response = await get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        List body = jsonDecode(response.body);
        final notes = <Note>[];
        for (Map<String, dynamic> note in body) notes.add(Note.fromJson(note));
        return notes;
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<Note> createNote(String title, String content, int categoryId) async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/note';
    Map<String, String> headers = {
      "Authorization": 'Bearer $authToken',
      "Content-type": "application/json"
    };
    String body = jsonEncode(
        Note(title: title, content: content, categoryId: categoryId));

    final response = await post(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        Map body = jsonDecode(response.body);
        return Note.fromJson(body);
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<void> updateNote(int id, String title, String content) async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/note';
    Map<String, String> headers = {
      "Authorization": 'Bearer $authToken',
      "Content-type": "application/json"
    };

    String body = jsonEncode(Note(id: id, title: title, content: content));

    final response = await put(url, headers: headers, body: body);

    switch (response.statusCode) {
      case 200:
        break;
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      case 404:
        print(response.body);
        throw new ServiceException(code: 'NOTE_NOT_FOUND');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<void> deleteNote(int id) async {
    final authToken = await _storage.read(key: 'authToken');

    if (authToken == null) return null;

    String url = '${DotEnv().env['BACKEND_URL']}/note/$id';
    Map<String, String> headers = {
      "Authorization": 'Bearer $authToken',
    };

    final response = await delete(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        break;
      case 401:
        print(response.body);
        throw new ServiceException(code: 'USER_NOT_CONNECTED');
      case 404:
        print(response.body);
        throw new ServiceException(code: 'NOTE_NOT_FOUND');
      default:
        print(response.body);
        throw new ServiceException(code: 'INTERNAL_SERVER_ERROR');
    }
  }
}
