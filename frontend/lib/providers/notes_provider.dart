import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  void updateNote(Note note) {
    int index = notes.indexOf(notes.firstWhere((ele) => ele.id == note.id));
    notes[index] = note;
    notifyListeners();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  void deleteNote(Note note) {
    int index = notes.indexOf(notes.firstWhere((ele) => ele.id == note.id));
    notes.removeAt(index);
    notifyListeners();
  }
}
