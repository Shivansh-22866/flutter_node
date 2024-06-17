import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void updateNote() {}

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void deleteNote(Note note) {}
}
