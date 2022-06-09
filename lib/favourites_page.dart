import 'package:chuck_norris/joke_saver.dart';
import 'package:chuck_norris/norris_joke.dart';
import 'package:flutter/material.dart';
import 'joke_popup.dart';

class FavouritesPage extends StatefulWidget {

  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritePage();
}

class _FavouritePage extends State<FavouritesPage> {
  List<NorrisJoke> _favouriteJokes = [];

  void _removeFromFavourite(int index) {
    setState(() {
      _favouriteJokes.removeAt(index);
    });
  }

  @override
  initState() {
    super.initState();
    //Load favourite jokes
    _favouriteJokes = [];
    LoadAllJokesFromDatabase().then((value) {
      setState((){
        _favouriteJokes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.separated(
            padding: const EdgeInsets.all(5),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: InkWell(
                    child: Text(_favouriteJokes[index].value, style: const TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return JokePopup(joke: _favouriteJokes[index]);
                        }
                      ));
                    },
                ),
                trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      DeleteJokeFromDatabase(_favouriteJokes[index]);
                      _removeFromFavourite(index);
                    },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: _favouriteJokes.length)
    );
  }

}