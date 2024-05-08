import 'package:ernel/app/notes.dart';
import 'package:ernel/app/song_types.dart';
import 'package:flutter/material.dart';

void mostrarNiveles(BuildContext context, Function(String nivel) callback) {
  Widget dialogo = SizedBox(
    width: double.maxFinite,
    child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,

        // Verificar en que paso del dialogo está
        // para mostrar notas o modalidades.
        children: List.generate(niveles.length, (index) {
          return MaterialButton(
            color: Colors.white,
            child: Text(
              niveles[index],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              String selectedNivel = niveles[index];
              callback(selectedNivel);
            },
          );
        })),
  );

  showSolidDialog(context, dialogo, 'Selecciona un Acorde');
}

void mostrarAlteraciones(
    BuildContext context, Function(String alteracion) callback) {
  Widget dialogo = SizedBox(
    width: double.maxFinite,
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,

      // Verificar en que paso del dialogo está
      // para mostrar notas o modalidades.
      children: List.generate(alteraciones.length, (index) {
        return MaterialButton(
          color: Colors.white,
          child: Text(
            alteraciones[index],
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            String selectedAlteracion = alteraciones[index];
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
            //         '${niveles[_selectedNivel.index]}${alteraciones[_selectedAlteracion.index]}',
            //   ),
            // );
            // print(cancion.toJson());
            // mainGridSongModel.setTono(
            //   payload.seccion,
            //   payload.compas,
            //   payload.tono,
            //   Tono(
            //     tono:
            //         '${niveles[_selectedNivel.index]}${alteraciones[_selectedAlteracion.index]}',
            //   ),
            // );
            // arreglo[payload.seccion]
            //         .compases[payload.compas][payload.tono]
            //         .tono =
            //     ;

            // callback(Tono(
            //   tono:
            //       '${niveles[_selectedNivel.index]}${alteraciones[_selectedAlteracion.index]}',
            // ));
          },
        );
      }),
    ),
  );

  showSolidDialog(context, dialogo, 'Selecciona la modalidad');
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
          backgroundColor: Colors.green,
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
