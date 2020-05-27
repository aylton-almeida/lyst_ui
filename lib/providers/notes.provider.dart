import 'package:flutter/material.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/services/note.service.dart';

class NotesProvider with ChangeNotifier {
  final _service = NoteService();
  List<Note> notes = [];
  List<Note> filteredNotes = [];
  Note currentNote;

  Future<void> doGetAllNotes() async {
    this.notes = await _service.getAllNotes();
    await _updateFilteredNotes(this.notes);
    notifyListeners();
  }

  Future<void> doGetCategoryNotes(int categoryId) async {
    this.notes = await _service.getCategoryNotes(categoryId);
    await _updateFilteredNotes(this.notes);
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

  Future<void> doUpdateNote(String title, String content) async {
    await _service.updateNote(currentNote.id, title, content);
    final note = this.notes.firstWhere((note) => note.id == currentNote.id);
    this.notes.remove(note);
    note.title = title;
    note.content = content;
    this.notes = [note, ...this.notes];
    notifyListeners();
  }

  Future<void> doDeleteNote(int id) async {
    await _service.deleteNote(id);
    this.notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void setCurrentNote(Note note) => this.currentNote = note;

  updateFilteredNotes(String filter) {
    if (filter.isEmpty || filter == null) {
      _updateFilteredNotes(this.notes);
    } else {
      List<Note> filtered = [];
      filtered.addAll(notes.where((note) =>
          note.title.toLowerCase().contains(filter.toLowerCase()) ||
          note.content.toLowerCase().contains(filter.toLowerCase())));
      filter.isNotEmpty
          ? _updateFilteredNotes(filtered)
          : _updateFilteredNotes(this.notes);
    }
    notifyListeners();
  }

  _updateFilteredNotes(List<Note> filteredNotes) async {
    this.filteredNotes.clear();
    this.filteredNotes.addAll(filteredNotes);
  }
}
