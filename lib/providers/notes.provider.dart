import 'package:flutter/material.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/services/note.service.dart';

class NotesProvider with ChangeNotifier {
  final _service = NoteService();
  List<Note> notes = [];
  Note currentNote;

  Future<void> doGetAllNotes() async {
    this.notes = await _service.getAllNotes();
    notifyListeners();
  }

  Future<void> doGetCategoryNotes(int categoryId) async {
    this.notes = await _service.getCategoryNotes(categoryId);
    notifyListeners();
  }

  Future<void> doCreateNote(
      String title, String content, int categoryId) async {
    this.notes = [
      await _service.createNote(title, content, categoryId),
      ...this.notes
    ];
    notifyListeners();
  }

  Future<void> doUpdateCategory(int id, String title, String content) async {
    await _service.updateNote(id, title, content);
    final note = this.notes.firstWhere((note) => note.id == id);
    this.notes.remove(note);
    note.title = title;
    note.content = content;
    this.notes = [note, ...this.notes];
    notifyListeners();
  }

  Future<void> doDeleteCategory(int id) async {
    await _service.deleteNote(id);
    this.notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void setCurrentNote(Note note) => this.currentNote = note;
}
