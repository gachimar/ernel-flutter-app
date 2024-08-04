import 'package:ernel/app/escalas.dart';
import 'package:ernel/app/song_types.dart';
import 'package:ernel/new_elements/utils/dialogs.dart';
import 'package:ernel/state/songs/gridsong_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridSongWidget extends StatefulWidget {
  const GridSongWidget({super.key, required this.seccion, required this.index});

  final Seccion seccion;
  final int index;
  @override
  State<GridSongWidget> createState() => _GridSongWidgetState();
}

class _GridSongWidgetState extends State<GridSongWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.seccion);
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                TableCell(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<MainGridSongProvider>(
                      builder: (
                        builder,
                        mainGridSongProvider,
                        child,
                      ) =>
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tono de la sección.
                          Text(
                            widget.seccion.tono,
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.green[800],
                                onPressed: () {
                                  print('Crear sección');
                                  mostrarAcordes(context, (tono) {
                                    print(tono);
                                    mostrarModos(context, (modo) {
                                      print(modo);
                                      mainGridSongProvider.setSeccionTono(
                                        widget.index,
                                        '$tono $modo',
                                      );
                                    });
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.green[800],
                                onPressed: () {
                                  print('Crear sección');
                                  mainGridSongProvider.removeSeccion(
                                    widget.index,
                                  );
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10),
                                ),
                                onPressed: () {
                                  mainGridSongProvider.addCompas(widget.index);
                                },
                                child: const Icon(Icons.add),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10),
                                ),
                                onPressed: () {
                                  mainGridSongProvider.removeLastCompas(widget.index);
                                },
                                child: const Icon(Icons.remove),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ),
              ],
            ),
            TableRow(
              children: <Widget>[
                TableCell(
                  child: Center(
                      child: Table(
                          border: TableBorder.all(
                              color: Colors.black38,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: widget.seccion.compases
                              .asMap()
                              .entries
                              .map((compas) {
                            return TableRow(
                              children: compas.value
                                  .asMap()
                                  .entries
                                  .map(
                                    (tono) => Consumer<MainGridSongProvider>(
                                      builder: (
                                        builder,
                                        mainGridSongProvider,
                                        child,
                                      ) =>
                                          TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.all(0)),
                                        onPressed: () {
                                          // Mostrar dialogo de grados.
                                          mostrarGrados(context, (grado) {
                                            // Si se presionó clear, borrar.
                                            if (grado == 'clear') {
                                              mainGridSongProvider.setTono(
                                                widget.index,
                                                compas.key,
                                                tono.key,
                                                Tono(tono: ""),
                                              );
                                              return;
                                            }
                                            mostrarAlteraciones(context,
                                                (tipo) {
                                              Tono nuevoTono =
                                                  Tono(tono: '$grado$tipo');
                                              mainGridSongProvider.setTono(
                                                  widget.index,
                                                  compas.key,
                                                  tono.key,
                                                  nuevoTono);
                                              print('$grado$tipo');
                                            });
                                          });
                                        },
                                        child: tono.value.tono != ""
                                            ? Text(
                                                acordes_list[widget.seccion
                                                    .tono]![tono.value.tono]!,
                                              )
                                            : const Text(''),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }).toList())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
