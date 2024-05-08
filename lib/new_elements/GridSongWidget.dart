import 'package:ernel/app/song_types.dart';
import 'package:ernel/new_elements/utils/dialogs.dart';
import 'package:flutter/material.dart';

class GridSongWidget extends StatefulWidget {
  const GridSongWidget({super.key, required this.seccion});

  final Seccion seccion;
  @override
  State<GridSongWidget> createState() => _GridSongWidgetState();
}

class _GridSongWidgetState extends State<GridSongWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.seccion);
    return Table(
      border: TableBorder.all(color: Colors.black26),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.seccion.tono),
              )),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Center(
                  child: Table(
                      border: TableBorder.all(color: Colors.black38),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children:
                          widget.seccion.compases.asMap().entries.map((compas) {
                        return TableRow(
                          children: compas.value
                              .asMap()
                              .entries
                              .map(
                                (tono) => GestureDetector(
                                  onTap: () {
                                    mostrarNiveles(context, (nivel) {
                                      mostrarAlteraciones(context,
                                          (alteracion) {
                                        print('$nivel$alteracion');
                                      });
                                    });
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Text(tono.value.tono != ''
                                          ? tono.value.tono
                                          : 'C#m7'),
                                    ),
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
    );
  }
}
