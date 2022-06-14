import 'package:flutter/material.dart';
import 'joke_saver.dart';

///Builds app bar with save node choice button
AppBar buildSaveModesAppBar() {
  return AppBar(
    title:
        const Text("Chuck Norris Jokes", style: TextStyle(color: Colors.white)),
    actions: [
      PopupMenuButton<SaveModes>(
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem(
              value: SaveModes.storage,
              child: Text("Use Storage"),
            ),
            PopupMenuItem(
              value: SaveModes.firestore,
              child: Text("Use Firestore"),
            )
          ];
        },
        onSelected: (value) {
          saveMode.value = value;
        },
      )
    ],
  );
}
