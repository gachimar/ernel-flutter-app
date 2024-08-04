import 'package:ernel/elements/mainpanel/actionbar/dialogs.dart';
import 'package:ernel/state/songs/gridsong_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongBarWidget extends StatelessWidget {
  const SongBarWidget({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Consumer<MainGridSongProvider>(
      builder: (builder, mainGridSongProvider, child) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                elevation: 3,
                shape: const CircleBorder(),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                crearCancionDialog(context);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          if (mainGridSongProvider.getCurrentSong() != null) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                elevation: 3,
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.save,
              ),
              onPressed: () {
                mainGridSongProvider.saveSong();
              },
            )
          ]
        ],
      ),
    );
  }
}
