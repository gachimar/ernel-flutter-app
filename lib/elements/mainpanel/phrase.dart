import 'package:ernel/app/notes.dart';
import 'package:ernel/elements/mainpanel/notelabel.dart';
import 'package:ernel/state/notes/notes_states.dart';
import 'package:ernel/state/ui/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhraseWidget extends StatefulWidget {
  const PhraseWidget({super.key, required this.phrase});

  final Phrase phrase;
  @override
  State<PhraseWidget> createState() => _PhraseWidgetState();
}

class _PhraseWidgetState extends State<PhraseWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotesModel>(
      builder: (context, mainNoteProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: widget.phrase.chords.map((Chord value) {
              return Consumer<MainNotesModel>(
                builder: (context, mainNoteProvider, child) => NoteLabel(
                  note: value,
                  mainNote: mainNoteProvider.getMainNote(),
                ),
              );
            }).toList(),
          ),
          Consumer<UiModel>(
            builder: (context, ui, child) => Text(
              widget.phrase.lyrics,
              style: TextStyle(
                  fontSize: 18.0 * ui.getScale(), color: Colors.blueGrey[900]),
            ),
          ),
        ],
      ),
    );
  }
}
