import 'package:chuck_norris/api_interactions.dart';
import 'package:flutter/material.dart';
import 'swipe_system.dart';
import 'norris_joke.dart';

///Widget to show when user opens joke from favourites page
class JokePopup extends StatelessWidget {
  final NorrisJoke joke;

  const JokePopup({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Chuck Norris Jokes",
        style: TextStyle(color: Colors.white),
      )),
      body: Center(
        child: JokeCard(
          joke: joke,
          image: getNorrisImageByIndex(joke.imageIndex!),
        ),
      ),
    );
  }
}
