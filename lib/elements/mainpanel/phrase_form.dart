import 'package:ernel/app/notes.dart';
import 'package:ernel/elements/mainpanel/notelabel.dart';
import 'package:ernel/state/ui/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhraseForm extends StatefulWidget {
  const PhraseForm({super.key});

  @override
  State<PhraseForm> createState() => _PhraseFormState();
}

class _PhraseFormState extends State<PhraseForm> {
  double _selectedPosition = 1;
  Note _selectedNote = indexedNotes[0];
  Mode _selectedMode = indexedModes[0];
  String _letra = '';

  List<Chord> _acordes = [
    Chord(note: 9, mode: 1, offset: 0),
    Chord(note: 9, mode: 0, offset: 100),
    Chord(note: 5, mode: 0, offset: 280),
  ];

  Chord getNewChord() => Chord(
      note: _selectedNote.index,
      mode: _selectedMode.index,
      offset: (_selectedPosition * 10));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Consumer<UiModel>(
        builder: (context, ui, child) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ..._acordes.map(
                  (Chord acorde) => NoteLabel(
                    note: acorde,
                    mainNote: Note(index: 0),
                  ),
                ),
                NoteLabel(
                  note: getNewChord(),
                  mainNote: Note(index: 0),
                )
              ],
            ),
            Text(
              _letra,
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 16.0 * ui.getScale(),
                  color: Colors.blueGrey[900]),
            ),
            TextFormField(
              maxLength: 34,
              onChanged: (String value) => {
                setState(() {
                  _letra = value;
                })
              },
              style: TextStyle(
                  fontSize: 18.0 * ui.getScale(), color: Colors.blueGrey[900]),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Ingresa la letra',
              ),
            ),
            Wrap(
              children: [
                DropdownButton<Note>(
                  value: _selectedNote,
                  onChanged: (Note? value) {
                    setState(() {
                      _selectedNote = value!;
                    });
                  },
                  items: indexedNotes
                      .map<DropdownMenuItem<Note>>(
                        (Note note) => DropdownMenuItem<Note>(
                          value: note,
                          child: Text(notes[note.index]),
                        ),
                      )
                      .toList(),
                ),
                DropdownButton<Mode>(
                  value: _selectedMode,
                  onChanged: (Mode? value) {
                    setState(() {
                      _selectedMode = value!;
                    });
                  },
                  items: indexedModes
                      .map<DropdownMenuItem<Mode>>(
                        (Mode mode) => DropdownMenuItem<Mode>(
                          value: mode,
                          child: Text(modes[mode.index]),
                        ),
                      )
                      .toList(),
                ),
              ],
              // TODO: HACER UNICOS LOS ACORDES
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Slider(
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
            ),
            Consumer(
              builder: (context, value, child) => MaterialButton(
                child: const Text('Agregar acorde'),
                onPressed: () => setState(
                  () => _acordes.add(
                    getNewChord(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
