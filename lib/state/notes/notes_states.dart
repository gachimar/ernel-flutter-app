import 'package:ernel/app/notes.dart';
import 'package:flutter/material.dart';

class MainNotesModel with ChangeNotifier {
  Note _mainNote;

  MainNotesModel(this._mainNote);

  getMainNote() => _mainNote;

  void setNote(Note newNote) {
    _mainNote = newNote;
    notifyListeners();
  }
}
