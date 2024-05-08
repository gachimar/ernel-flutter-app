// To parse this JSON data, do
//
//     final gridSong = gridSongFromJson(jsonString);

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String getGridSong(String name) {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  String gridSong = 
      '{"name":"$name","author":"Ernel Dev. team.","tempo":8,"secciones":[]}';

  // GridSong gridSongPreference = gridSongFromJson(prefs.getString('action')!);
  return gridSong;
}
// GridSong gridSong = gridSongFromJson(
//     '{"name":"Ernel test song.","author":"Ernel Dev. team.","tempo":8,"secciones":[{"tono":"C Mayor","compases":[]}]}');

GridSong gridSongFromJson(String str) => GridSong.fromJson(json.decode(str));

String gridSongToJson(GridSong data) => json.encode(data.toJson());

class GridSong {
  String name;
  String author;
  int tempo;
  List<Seccion> secciones;

  GridSong({
    required this.name,
    required this.author,
    required this.tempo,
    required this.secciones,
  });

  factory GridSong.fromJson(Map<String, dynamic> json) => GridSong(
        name: json["name"],
        author: json["author"],
        tempo: json["tempo"],
        secciones: List<Seccion>.from(
            json["secciones"].map((x) => Seccion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "tempo": tempo,
        "secciones": List<dynamic>.from(secciones.map((x) => x.toJson())),
      };
}

class Seccion {
  String tono;
  List<List<Tono>> compases;

  Seccion({
    required this.tono,
    required this.compases,
  });

  factory Seccion.fromJson(Map<String, dynamic> json) => Seccion(
        tono: json["tono"],
        compases: List<List<Tono>>.from(
          json["compases"].map(
            (x) => List<Tono>.from(
              x.map(
                (x) => Tono.fromJson(x),
              ),
            ),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "tono": tono,
        "compases": List<dynamic>.from(
          compases.map(
            (x) => List<dynamic>.from(
              x.map(
                (x) => x.toJson(),
              ),
            ),
          ),
        ),
      };
}

class Tono {
  String tono;

  Tono({
    required this.tono,
  });

  factory Tono.fromJson(Map<String, dynamic> json) => Tono(
        tono: json["tono"],
      );

  Map<String, dynamic> toJson() => {
        "tono": tono,
      };
}
