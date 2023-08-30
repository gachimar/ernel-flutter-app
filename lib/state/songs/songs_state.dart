import 'package:ernel/app/notes.dart';
import 'package:flutter/material.dart';

class MainSongModel with ChangeNotifier {
  SongModel _currentSong;

  MainSongModel(this._currentSong);

  getCurrentSong() => _currentSong;

  void setCurrentSong(SongModel newSong) {
    _currentSong = newSong;
    notifyListeners();
  }

  void addPhrase(Phrase newPhrase) {
    _currentSong.phrases.add(newPhrase);
    notifyListeners();
  }
}
