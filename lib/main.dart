import 'package:flutter/material.dart';
import 'swipe_system.dart';
import 'api_interactions.dart';

void main() {
  runApp(const MyApp());
}

//Main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Chuck Norris Jokes",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black87,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: FutureBuilder<List<String>>(
                //Using future builder to show something to user, while loading first three jokes
                future: loadThreeJokes(),
                builder: (BuildContext buildContext,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return SwipingWidget(
                      //My custom widget for swiping
                      startingCards: [
                        JokeCard(
                            jokeText: snapshot.data![0],
                            image: getRandomNorrisImage()),
                        JokeCard(
                            jokeText: snapshot.data![1],
                            image: getRandomNorrisImage()),
                        JokeCard(
                            jokeText: snapshot.data![2],
                            image: getRandomNorrisImage())
                      ],
                      onSwiped: (emptyCard, swipeSystem) {
                        Future<String> jokeFromInternet = loadNorrisJoke();
                        jokeFromInternet.then((value) {
                          JokeCard newCard = JokeCard(
                              jokeText: value, image: getRandomNorrisImage());
                          swipeSystem.replace(emptyCard, newCard);
                        });
                      },
                    );
                  } else if (snapshot.hasError) {
                    //If any error occurred, show error message
                    return const Center(
                      child: Text(
                        "Unknown error (check internet connection)",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    );
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
              ),
            ),
          )),
    );
  }
}
