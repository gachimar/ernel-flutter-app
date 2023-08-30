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
  int _selectedNote = 0;
  String _letra = '';

  List<Chord> _acordes = [
    Chord(note: 9, mode: 1, offset: 0),
    Chord(note: 9, mode: 0, offset: 100),
    Chord(note: 5, mode: 0, offset: 280),
  ];

  Chord getNewChord() =>
      Chord(note: _selectedNote, mode: 0, offset: (_selectedPosition * 10));

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
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 18.0 * ui.getScale(),
                  color: Colors.blueGrey[900]),
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
            TextFormField(
              maxLength: 30,
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
            Consumer(
              builder: (context, value, child) => MaterialButton(
                  child: const Text('Agregar acorde'),
                  onPressed: () =>
                      {setState(() => _acordes.add(getNewChord()))}),
            )
          ],
        ),
      ),
    );
  }
}
