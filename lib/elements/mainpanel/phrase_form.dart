import 'package:ernel/app/notes.dart';
import 'package:ernel/elements/mainpanel/notelabel.dart';
import 'package:ernel/elements/mainpanel/phrase_form_display.dart';
import 'package:ernel/state/songs/songs_state.dart';
import 'package:ernel/state/ui/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhraseForm extends StatefulWidget {
  const PhraseForm({super.key});

  @override
  State<PhraseForm> createState() => _PhraseFormState();
}

class _PhraseFormState extends State<PhraseForm> {
  // Posición del acorde
  double _selectedPosition = 0;

  // Nota del acorde seleccionada
  Note _selectedNote = indexedNotes[0];

  // Modalidad seleccionada
  Mode _selectedMode = indexedModes[0];

  // Letra actual
  String _letra = '';

  //// Pasos del formulario { 0: Letras, 1 : Acordes }
  int _paso = 0;

  // Pasos internos
  // Mostrar slider
  bool _mostrarPocisionSlider = false;
  bool _creandoUnAcorde = false;

  // Lista de acordes
  List<Chord> _acordes = [];

  // Controlador del Cuadro de texto de la letra
  final _letraController = TextEditingController();

  Chord getNuevoAcorde() => Chord(
      note: _selectedNote.index,
      mode: _selectedMode.index,
      offset: (_selectedPosition * 10));

  Phrase getFinalPhrase() {
    Phrase finalPhrase = Phrase(
      lyrics: _letra,
      chords: _acordes,
      duration: Duration(finishAt: "0:00:00;00", startAt: "0:00:00;00"),
    );
    return finalPhrase;
  }

  void mostrarAcordes() {
    Widget dialogo = SizedBox(
      width: double.maxFinite,
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,

          // Verificar en que paso del dialogo está
          // para mostrar notas o modalidades.
          children: List.generate(12, (index) {
            return MaterialButton(
              color: Colors.white,
              child: Text(
                notes[index],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedNote = Note(index: (index));

                  Navigator.of(context).pop();
                  mostrarModos();
                });
              },
            );
          })),
    );

    mostrarDialogo(dialogo, 'Selecciona un Acorde');
  }

  void mostrarModos() {
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
              setState(() {
                _selectedMode = Mode(index: (index));
              });
              Navigator.of(context).pop();
            },
          );
        }),
      ),
    );

    mostrarDialogo(dialogo, 'Selecciona la modalidad');
  }

  void mostrarDialogo(Widget contenido, String titulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.red,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Consumer<UiModel>(
        builder: (context, ui, child) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display de los Acordes
            PhraseFormDisplay(
              mostrarNuevoAcorde: _creandoUnAcorde,
              acordes: _acordes,
              nuevoAcorde: getNuevoAcorde(),
            ),

            // Display de la letra
            Text(
              _letra,
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 16.0 * ui.getScale(),
                  color: Colors.black54),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                '(Previsualización)',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black38,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // Poner la letra
            if (_paso == 0)
              // Label de la letra
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onFieldSubmitted: (String valor) {
                      if (_letraController.text.isNotEmpty) {
                        setState(
                          () => _paso = 1,
                        );
                      }
                    },
                    controller: _letraController,
                    maxLength: 34,
                    onChanged: (String value) => {
                      setState(() {
                        _letra = value;
                      })
                    },
                    style: TextStyle(
                        fontSize: 18.0 * ui.getScale(),
                        color: Colors.blueGrey[900]),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Ingresa la letra',
                    ),
                  ),
                  MaterialButton(
                    color: _letraController.text.isNotEmpty
                        ? Colors.blue
                        : Colors.black12,
                    textColor: Colors.white,
                    child: const Text('Siguiente'),
                    onPressed: () {
                      if (_letraController.text.isNotEmpty) {
                        setState(
                          () => _paso = 1,
                        );
                      }
                    },
                  )
                ],
              ),
            // Poner Acordes
            if (_paso == 1)
              // Comandos para añadir acordes.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Condicion de mostrar el slider si ya se seleccionó un acorde.
                  if (_mostrarPocisionSlider)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:
                          // Slider de la posición de los acordes.
                          Column(
                        children: [
                          const Text(
                            'Arrastra y selecciona la posición',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          Slider(
                            activeColor: Colors.black12,
                            inactiveColor: Colors.black12,
                            thumbColor: Colors.red,
                            value: _selectedPosition,
                            max: 28,
                            min: 0,
                            // label: _selectedPosition.toString(),
                            onChanged: (double value) {
                              setState(() {
                                _selectedPosition = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Acordes:',
                        style: TextStyle(color: Colors.black54),
                      ),
                      if (!_mostrarPocisionSlider)
                        Wrap(
                          spacing: 10,
                          children: [
                            MaterialButton(
                                color: Colors.red,
                                textColor: Colors.white,
                                child: const Text('Agregar acorde'),
                                onPressed: () {
                                  setState(() {
                                    _creandoUnAcorde = true;
                                  });
                                  mostrarAcordes();
                                }),
                            Consumer(
                              builder: (context, value, child) =>
                                  MaterialButton(
                                color: Colors.black38,
                                textColor: Colors.white,
                                child: const Text('Eliminar ultimo acorde'),
                                onPressed: () {
                                  if (_acordes.isNotEmpty) {
                                    setState(() {
                                      _acordes.removeLast();
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      if (_mostrarPocisionSlider)
                        Wrap(
                          spacing: 10,
                          children: [
                            MaterialButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: const Text('Guardar Acorde'),
                                onPressed: () {
                                  setState(() {
                                    _acordes.add(
                                      getNuevoAcorde(),
                                    );
                                    _mostrarPocisionSlider = false;
                                    _creandoUnAcorde = false;
                                    _selectedPosition = 0;
                                  });
                                }),
                            Consumer(
                              builder: (context, value, child) =>
                                  MaterialButton(
                                color: Colors.black38,
                                textColor: Colors.white,
                                child: const Text('Cancelar'),
                                onPressed: () => setState(
                                  () => _mostrarPocisionSlider = false,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const Divider(),
                  // Botones de paso 2.
                  Wrap(
                    spacing: 10,
                    children: [
                      // Boton de siguiente

                      // Boton para atras
                      Consumer<MainSongModel>(
                        builder: (context, mainSongProvider, child) =>
                            MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text('Guardar'),
                          onPressed: () => setState(
                            () => mainSongProvider.addPhrase(getFinalPhrase()),
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Text('Modificar letra',
                            style: TextStyle(color: Colors.black54)),
                        onPressed: () => setState(
                          () {
                            _paso = 0;
                            _letraController.text = (_letra);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            if (_paso == 3) ...[
              Column(
                children: [
                  Wrap(
                    spacing: 10,
                    children: [
                      Consumer<MainSongModel>(
                        builder: (context, mainSongProvider, child) =>
                            MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text('Eliminar ultima phrase'),
                          onPressed: () => setState(
                            () => mainSongProvider.removeLastPhrase(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}

class FlatButton {}
