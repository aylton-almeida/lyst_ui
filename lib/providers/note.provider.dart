import 'package:flutter/material.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/services/note.service.dart';

class NoteProvider with ChangeNotifier {
  final _service = NoteService();
  List<Note> notes = [];

  Future<void> doGetCategoryNotes(int categoryId) async {
    this.notes = await _service.getCategoryNotes(categoryId);
    notifyListeners();
  }
}
