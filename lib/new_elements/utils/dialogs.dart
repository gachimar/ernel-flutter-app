import 'package:ernel/app/notes.dart';
import 'package:ernel/app/song_types.dart';
import 'package:flutter/material.dart';

void mostrarGrados(BuildContext context, Function(String grado) callback) {
  Widget dialogo = SizedBox(
    width: double.maxFinite,
    child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,

        // Verificar en que paso del dialogo está
        // para mostrar notas o modalidades.
        children: [
          ...List.generate(grados.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: MaterialButton(
                color: Colors.white,
                child: Text(
                  grados[index],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  String selectedGrado = grados[index];
                  callback(selectedGrado);
                },
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: MaterialButton(
              color: Colors.white,
              child: const Text(
                'Limpiar',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                callback('clear');
              },
            ),
          )
        ]),
  );

  showSolidDialog(context, dialogo, 'Selecciona un Acorde');
}

void mostrarAlteraciones(BuildContext context, Function(String tipo) callback) {
  Widget dialogo = SizedBox(
    width: double.maxFinite,
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,

      // Verificar en que paso del dialogo está
      // para mostrar notas o modalidades.
      children: List.generate(tipos.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: MaterialButton(
            color: Colors.white,
            child: Text(
              tipos[index],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              String selectedAlteracion = tipos[index];
              callback(selectedAlteracion);
              // GridSong cancion =
              //     Provider.of<MainGridSongProvider>(context, listen: false)
              //         .getCurrentSong();
              // Provider.of<MainGridSongProvider>(context, listen: false)
              //     .setTono(
              //   payload.seccion,
              //   payload.compas,
              //   payload.tono,
              //   Tono(
              //     tono:
              //         '${grados[_selectedNivel.index]}${tipos[_selectedAlteracion.index]}',
              //   ),
              // );
              // print(cancion.toJson());
              // mainGridSongModel.setTono(
              //   payload.seccion,
              //   payload.compas,
              //   payload.tono,
              //   Tono(
              //     tono:
              //         '${grados[_selectedNivel.index]}${tipos[_selectedAlteracion.index]}',
              //   ),
              // );
              // arreglo[payload.seccion]
              //         .compases[payload.compas][payload.tono]
              //         .tono =
              //     ;

              // callback(Tono(
              //   tono:
              //       '${grados[_selectedNivel.index]}${tipos[_selectedAlteracion.index]}',
              // ));
            },
          ),
        );
      }),
    ),
  );

  showSolidDialog(context, dialogo, 'Tipo de Acorde');
}

void showSolidDialog(
  BuildContext context,
  Widget contenido,
  String titulo,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.green[500],
          title: Center(
              child: Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )),
          content: contenido);
    },
  );
}

void mostrarAcordes(
  BuildContext context,
  Function(String acorde) callback,
) {
  Widget dialogo = SizedBox(
    width: double.maxFinite,
    child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,

        // Verificar en que paso del dialogo está
        // para mostrar notas o modalidades.
        children: List.generate(notes.length, (index) {
          return MaterialButton(
            color: Colors.white,
            child: Text(
              notes[index],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              callback(notes[index]);
            },
          );
        })),
  );

  showSolidDialog(context, dialogo, 'Selecciona un Acorde');
}

void mostrarModos(
  BuildContext context,
  Function(String acorde) callback,
) {
  Widget dialogo = SizedBox(
    width: double.maxFinite,
    child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,

        // Verificar en que paso del dialogo está
        // para mostrar notas o modalidades.
        children: List.generate(modes.length, (index) {
          return MaterialButton(
            color: Colors.white,
            child: Text(
              modes[index],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              callback(modes[index]);
            },
          );
        })),
  );

  showSolidDialog(context, dialogo, 'Selecciona un Acorde');
}
