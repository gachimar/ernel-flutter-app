import 'package:ernel/app/song_types.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainGridSongProvider with ChangeNotifier {
  GridSong? _currentSong;

  late final SharedPreferences _sharedPrefs;

  MainGridSongProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _sharedPrefs = await SharedPreferences.getInstance();

    loadCurrentSong();
    notifyListeners();
  }

  GridSong? getCurrentSong() => _currentSong;

  void setCurrentSong(
    GridSong newSong,
  ) {
    _currentSong = newSong;
    notifyListeners();
  }

  void addSeccion(
    String seccionTono,
  ) {
    Seccion newSeccion = Seccion(tono: seccionTono, compases: [
      [
        Tono(tono: ''),
        Tono(tono: ''),
        Tono(tono: ''),
        Tono(tono: ''),
        Tono(tono: ''),
        Tono(tono: ''),
        Tono(tono: ''),
        Tono(tono: ''),
      ]
    ]);
    _currentSong!.secciones.add(newSeccion);
    notifyListeners();
  }

  void loadCurrentSong() {
    String? prefCurrentSong = _sharedPrefs.getString('current_song');

    if (prefCurrentSong != null) {
      _currentSong = gridSongFromJson(prefCurrentSong);
    }
    notifyListeners();
  }

  bool currentSongExists() {
    String? prefCurrentSong = _sharedPrefs.getString('current_song');
    return prefCurrentSong != null;

    // else {
    //   _currentSong = gridSongFromJson(prefCurrentSong);
    // }
  }

  // String getPrefCurrentSong() {
  //   return '';
  // }

  void createNewSong(
    String name,
  ) {
    String songJson = getGridSong(name);
    _currentSong = gridSongFromJson(songJson);
    setPreferencesSong(songJson);
    notifyListeners();
  }

  void setPreferencesSong(
    String song,
  ) async {
    await _sharedPrefs.setString('current_song', song);
  }

  void addCompas(
    int seccionIndex,
  ) {
    _currentSong!.secciones[seccionIndex].compases.add([
      Tono(tono: ""),
      Tono(tono: ""),
      Tono(tono: ""),
      Tono(tono: ""),
      Tono(tono: ""),
      Tono(tono: ""),
      Tono(tono: ""),
      Tono(tono: ""),
    ]);
    notifyListeners();
  }

  void removeLastCompas(
    int seccionIndex,
  ) {
    if (_currentSong!.secciones[seccionIndex].compases.length > 1) {
      _currentSong!.secciones[seccionIndex].compases.removeLast();
      notifyListeners();
    }
  }

  void setTono(
    int seccionIndex,
    int compasIndex,
    int tonoIndex,
    Tono nuevoTono,
  ) {
    _currentSong!.secciones[seccionIndex].compases[compasIndex][tonoIndex] =
        nuevoTono;
    print('lo hice chamo');
    notifyListeners();
  }

  void setSeccionTono(
    int seccionIndex,
    String nuevoTono,
  ) {
    _currentSong!.secciones[seccionIndex].tono = nuevoTono;
    print('lo hice chamo');
    notifyListeners();
  }

  void removeSeccion(
    int seccionIndex,
  ) {
    _currentSong!.secciones.removeAt(seccionIndex);
    notifyListeners();
  }

  void saveSong() async {
    if (_currentSong == null) {
      return;
    }
    String stringCurrentSong = gridSongToJson(_currentSong!);
    await _sharedPrefs.setString('current_song', stringCurrentSong);
  }
}
