import 'package:ernel/state/songs/gridsong_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget yesNoDialog(BuildContext context, Function callback) {
  Widget dialogo = SizedBox(
    child: Center(
      heightFactor: 0.5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                callback();

                Navigator.of(context).pop();
              },
              child: const Text(
                'Si',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 16, 0, 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  return dialogo;
}

void showFormDialog(BuildContext context, Widget contenido, String titulo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            titulo,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 20,
            ),
          )),
          content: contenido);
    },
  );
}

void crearCancionDialog(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = "";
  Widget dialogo = SizedBox(
    child: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Nombre...',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa un nombre válido.';
              }
              name = value;
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (formKey.currentState!.validate()) {
                  bool currentSongExist =
                      Provider.of<MainGridSongProvider>(context, listen: false)
                          .currentSongExists();
                  print(currentSongExist);

                  Navigator.of(context).pop();
                  if (currentSongExist) {
                    showFormDialog(context,
                        yesNoDialog(
                            context,
                            () => {
                                  Provider.of<MainGridSongProvider>(context,
                                          listen: false)
                                      .createNewSong(name)
                                }),
                        '¿Deseas sobreescribir la canción actual?');
                  } else {
                    Provider.of<MainGridSongProvider>(context, listen: false)
                        .createNewSong(name);
                  }
                }
              },
              child: const Text(
                'Crear canción',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  showFormDialog(context, dialogo, 'Nueva canción');
}
