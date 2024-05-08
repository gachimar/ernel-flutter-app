import 'package:ernel/app/notes.dart';
import 'package:ernel/elements/mainpanel/notelabel.dart';
import 'package:flutter/material.dart';

class PhraseFormDisplay extends StatefulWidget {
  const PhraseFormDisplay(
      {super.key,
      required this.acordes,
      required this.nuevoAcorde,
      this.mostrarNuevoAcorde = true});
  final List<Chord> acordes;
  final Chord nuevoAcorde;
  final bool mostrarNuevoAcorde;
  @override
  State<PhraseFormDisplay> createState() => _PhraseFormDisplayState();
}

class _PhraseFormDisplayState extends State<PhraseFormDisplay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...widget.acordes.map(
          (Chord acorde) => NoteLabel(
            note: acorde,
            mainNote: Note(index: 0),
          ),
        ),
        if (widget.mostrarNuevoAcorde)
          NoteLabel(
            note: widget.nuevoAcorde,
            mainNote: Note(index: 0),
            labelColor: Colors.orange[600]!,
          ),
      ],
    );
  }
}
