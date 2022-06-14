import 'package:chuck_norris/filter.dart';
import 'package:chuck_norris/norris_joke.dart';
import 'package:flutter/material.dart';
import 'swipe_system.dart';
import 'api_interactions.dart';

///Main page is widget that renders swiping system with jokes, uses future builder
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: FutureBuilder<List<NorrisJoke>>(
          //Using future builder to show something to user, while loading first three jokes
          future: loadThreeJokesByCategory(filteredCategories),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<NorrisJoke>> snapshot) {
            if (snapshot.hasData) {
              return SwipingWidget(
                //My custom widget for swiping
                startingCards: [
                  JokeCard(
                      joke: snapshot.data![0],
                      image:
                          getNorrisImageByIndex(snapshot.data![0].imageIndex!)),
                  JokeCard(
                      joke: snapshot.data![1],
                      image:
                          getNorrisImageByIndex(snapshot.data![1].imageIndex!)),
                  JokeCard(
                      joke: snapshot.data![2],
                      image:
                          getNorrisImageByIndex(snapshot.data![2].imageIndex!))
                ],
                onSwiped: (emptyCard, swipeSystem) {
                  Future<NorrisJoke> jokeFromInternet =
                      loadNorrisJokeByCategory(filteredCategories);
                  jokeFromInternet.then((value) {
                    JokeCard newCard = JokeCard(
                        joke: value,
                        image: getNorrisImageByIndex(value.imageIndex!));
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
    );
  }
}
