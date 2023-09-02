import 'dart:convert';

const double globalsize = 1;

SongModel exampleSong = songModelFromJson('''{
    "name" : "Cha cha cha",
    "author" : "Josean Log",
    "mainNote" : "F",
    "duration" : "2:00:15;00",
    "phrases" : [
        {   
            "lyrics" : "[ Intro ] ...",
            "chords" :[
                {
                    "note" : 5,
                    "mode" : 0,
                    "offset" : 0.0
                },
                {
                    "note" : 2,
                    "mode" : 1,
                    "offset" : 50.0
                },
                {
                    "note" : 9,
                    "mode" : 1,
                    "offset" : 170.0
                },
                {
                    "note" : 9,
                    "mode" : 0,
                    "offset" : 280.0
                }
            ],
            "duration" : {
                "startAt" : "0:00:15;00",
                "finishAt" : "0:00:25;00"
            }
        },
        {   
            "lyrics" :".. Dame de tu vida y de tu tiempo",
            "chords" :[
                {
                    "note" : 5,
                    "mode" : 0,
                    "offset" : 0.0
                },
                {
                    "note" : 2,
                    "mode" : 1,
                    "offset" : 280.0
                }
            ],
            "duration" : {
                "startAt" : "0:00:15;00",
                "finishAt" : "0:00:25;00"
            }
        },
        {   
            "lyrics" : "          Suficientes para ver",
            "chords" :[
                {
                    "note" : 9,
                    "mode" : 1,
                    "offset" : 0.0
                },
                {
                    "note" : 9,
                    "mode" : 0,
                    "offset" : 100.0
                }
                ,
                {
                    "note" : 5,
                    "mode" : 0,
                    "offset" : 280.0
                }
            ],
            "duration" : {
                "startAt" : "0:00:15;00",
                "finishAt" : "0:00:25;00"
            }
        }
    ]
}''');

/// Notas musicales.
List<String> notes = [
  'Do',
  'Do#',
  'Re',
  'Re#',
  'Mi',
  'Fa',
  'Fa#',
  'Sol',
  'Sol#',
  'La',
  'La#',
  'Si'
];

List<String> modes = [
  'M',
  'm',
  '7',
  'm7',
];

List<Note> indexedNotes = [
  Note(index: 0),
  Note(index: 1),
  Note(index: 2),
  Note(index: 3),
  Note(index: 4),
  Note(index: 5),
  Note(index: 6),
  Note(index: 7),
  Note(index: 8),
  Note(index: 9),
  Note(index: 10),
  Note(index: 11),
];

List<Mode> indexedModes = [
  Mode(index: 0),
  Mode(index: 1),
  Mode(index: 2),
  Mode(index: 3)
];

// ignore: camel_case_types

// Nota para la lista de notas principales.
class Note extends Object {
  int index;

  Note({this.index = 0});
}

// Nota para la lista de notas principales.
class Mode extends Object {
  int index;

  Mode({this.index = 0});
}

class Song {
  const Song({this.chords});

  final List<Note>? chords;
}

/// Cancion Ejemplo.
Song song = Song(chords: [
  Note(index: 0),
  Note(index: 10),
]);

// To parse this JSON data, do
//
//     final songModel = songModelFromJson(jsonString);

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  String name;
  String author;
  String mainNote;
  String duration;
  List<Phrase> phrases;

  SongModel({
    required this.name,
    required this.author,
    required this.mainNote,
    required this.duration,
    required this.phrases,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        name: json["name"],
        author: json["author"],
        mainNote: json["mainNote"],
        duration: json["duration"],
        phrases:
            List<Phrase>.from(json["phrases"].map((x) => Phrase.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "mainNote": mainNote,
        "duration": duration,
        "phrases": List<dynamic>.from(phrases.map((x) => x.toJson())),
      };
}

class Phrase {
  String lyrics;
  List<Chord> chords;
  Duration duration;

  Phrase({
    required this.lyrics,
    required this.chords,
    required this.duration,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) => Phrase(
        lyrics: json["lyrics"],
        chords: List<Chord>.from(json["chords"].map((x) => Chord.fromJson(x))),
        duration: Duration.fromJson(json["duration"]),
      );

  Map<String, dynamic> toJson() => {
        "lyrics": lyrics,
        "chords": List<dynamic>.from(chords.map((x) => x.toJson())),
        "duration": duration.toJson(),
      };
}

class Chord {
  int note;
  int mode;
  double offset;

  Chord({
    required this.note,
    required this.mode,
    required this.offset,
  });

  factory Chord.fromJson(Map<String, dynamic> json) => Chord(
        note: json["note"],
        mode: json["mode"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "note": note,
        "mode": mode,
        "offset": offset,
      };
}

class Duration {
  String startAt;
  String finishAt;

  Duration({
    required this.startAt,
    required this.finishAt,
  });

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        startAt: json["startAt"],
        finishAt: json["finishAt"],
      );

  Map<String, dynamic> toJson() => {
        "startAt": startAt,
        "finishAt": finishAt,
      };
}
