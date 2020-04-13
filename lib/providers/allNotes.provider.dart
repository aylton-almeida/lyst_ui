import 'package:flutter/material.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/services/note.service.dart';

class AllNotesProvider with ChangeNotifier {
  final _service = NoteService();
  List<Note> allNotes = [];

  Future<void> doGetAllNotes() async {
    this.allNotes = await _service.getAllNotes();
    notifyListeners();
  }
}
