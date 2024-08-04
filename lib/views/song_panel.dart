import 'package:ernel/elements/mainpanel/actionbar/song_bar.dart';
import 'package:ernel/new_elements/GridSongWidget.dart';
import 'package:ernel/new_elements/utils/dialogs.dart';
import 'package:ernel/state/songs/gridsong_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongPanel extends StatelessWidget {
  const SongPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Consumer<MainGridSongProvider>(
          builder: (builder, mainGridSongProvider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  children: [
                    Text('Cancion:'),
                  ],
                ),
              ),
              const SongBarWidget(),
              ...[
                const Divider(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Nombre:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    mainGridSongProvider.getCurrentSong() != null
                        ? Text(
                            mainGridSongProvider.getCurrentSong()!.name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          )
                        : const Text(
                            'Seleccione una canción',
                          ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Row(
                    children: [
                      Text('Secciones:'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          elevation: 3,
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          print('Crear sección');
                          mostrarAcordes(context, (tono) {
                            print(tono);
                            mostrarModos(context, (modo) {
                              print(modo);
                              mainGridSongProvider.addSeccion('$tono $modo');
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
              ...mainGridSongProvider.getCurrentSong() != null
                  ? mainGridSongProvider
                      .getCurrentSong()!
                      .secciones
                      .asMap()
                      .entries
                      .map((seccion) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GridSongWidget(
                          seccion: seccion.value,
                          index: seccion.key,
                        ),
                      );
                    }).toList()
                  : [],
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  child: Text(
                    'Presiona para añadir sección...',
                    style: TextStyle(
                      color: Colors.green[300],
                    ),
                  ),
                  onPressed: () {
                    print('Crear sección');
                    mostrarAcordes(context, (tono) {
                      print(tono);
                      mostrarModos(context, (modo) {
                        print(modo);
                        mainGridSongProvider.addSeccion('$tono $modo');
                      });
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
  }
}