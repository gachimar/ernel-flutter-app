import 'package:ernel/app/notes.dart';
import 'package:ernel/state/notes/notes_states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesDropdown extends StatefulWidget {
  const NotesDropdown({super.key});

  @override
  State<NotesDropdown> createState() => _NotesDropdownState();
}

class _NotesDropdownState extends State<NotesDropdown> {
  Note note = indexedNotes.first;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotesModel>(
      builder: (context, mainNoteProvider, child) {
        return DropdownButton<Note>(
          value: note,
          onChanged: (Note? value) {
            // This is called when the user selects an item.
            mainNoteProvider.setNote(value!);
            setState(() {
              note = value;
            });
          },
          items: indexedNotes.map<DropdownMenuItem<Note>>((Note value) {
            return DropdownMenuItem<Note>(
              value: value,
              child: Text(notes[value.index]),
            );
          }).toList(),
        );
      },
    );
  }
}
