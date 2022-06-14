import 'package:chuck_norris/joke_saver.dart';
import 'package:chuck_norris/norris_joke.dart';
import 'package:flutter/material.dart';
import 'joke_popup.dart';

///Widget for favourite jokes page
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritePage();
}

class _FavouritePage extends State<FavouritesPage> {
  List<NorrisJoke> _favouriteJokes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //Load favourite jokes from firebase
        child: ValueListenableBuilder<SaveModes>(
      valueListenable: saveMode,
      builder: (BuildContext context, SaveModes value, Widget? _) {
        return FutureBuilder<List<NorrisJoke>>(
          future: loadAllJokes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NorrisJoke>> snapshot) {
            if (snapshot.hasData) {
              _favouriteJokes = snapshot.data!;
              return ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: InkWell(
                        child: Text(_favouriteJokes[index].value,
                            style: const TextStyle(fontSize: 20)),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                            return JokePopup(joke: _favouriteJokes[index]);
                          }));
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          deleteJoke(_favouriteJokes[index]).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: _favouriteJokes.length);
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text("Error: Check your internet connection"));
            } else {
              return const Center(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    ));
  }
}
