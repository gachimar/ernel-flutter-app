import 'package:ernel/app/notes.dart';
import 'package:ernel/state/ui/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteLabel extends StatefulWidget {
  const NoteLabel({
    super.key,
    required this.note,
    required this.mainNote,
    this.labelColor = Colors.red,
  });

  final Chord note;
  final Note mainNote;
  final Color labelColor;

  @override
  State<NoteLabel> createState() => _NoteLabelState();
}

class _NoteLabelState extends State<NoteLabel> {
  /// Obtener la nota traspuesta.
  Chord traspNote() {
    int newIndex = widget.note.note + widget.mainNote!.index;

    if (newIndex > 11) {
      newIndex = newIndex - 12;
    }

    Chord trasposedNote = Chord(
      note: newIndex,
      mode: widget.note.mode,
      offset: 0,
    );

    return trasposedNote;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiModel>(
      builder: (context, ui, child) => Padding(
        padding:
            EdgeInsets.fromLTRB(widget.note.offset * ui.getScale(), 40, 0, 5),
        // child: Text('${notes[widget.note!.index]} ${traspNote().name}'),
        child: Text(
          textScaleFactor: 1.0,
          '${notes[traspNote().note]}${modes[traspNote().mode] == 'M' ? '' : modes[traspNote().mode]}',
          style: TextStyle(
            fontSize: 17.0 * ui.getScale(),
            color: widget.labelColor,
            fontFamily: 'RobotoMono',
          ),
        ),
      ),
    );
  }
}
