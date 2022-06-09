import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'norris_joke.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';



void SaveJokeToDatabase(NorrisJoke joke) async {
  var jokeJSON = joke.toJson();
  jokeJSON['imageIndex'] = joke.imageIndex;
  FirebaseFirestore.instance.collection('jokes').add({"joke": jsonEncode(jokeJSON)});
}

Future<List<NorrisJoke>> LoadAllJokesFromDatabase() async {
  final items = await FirebaseFirestore.instance.collection('jokes').get();
  List<NorrisJoke> jokes = [];
  items.docs.forEach((element) {
    var jokeJSON = jsonDecode(element.data()["joke"]);
    jokes.add(NorrisJoke.fromJson(jokeJSON));
    jokes.last.imageIndex = jokeJSON["imageIndex"];
  });

  return jokes;
}

void DeleteJokeFromDatabase(NorrisJoke joke) async {
  final items = await FirebaseFirestore.instance.collection('jokes').get();
  for(var item in items.docs) {
    NorrisJoke currentJoke = NorrisJoke.fromJson(jsonDecode(item.data()["joke"]));
    if(currentJoke.id == joke.id) {
      FirebaseFirestore.instance.collection('jokes').doc(item.id).delete();
      break;
    }
  }
}

void SaveJokeToStorage(NorrisJoke joke) async {
  //Save is not implemented on web
  if(kIsWeb)
    return;

  int index = 1;

  final documentsDirectory = await getApplicationDocumentsDirectory();
  File file = File('${documentsDirectory.path}/norris_joke$index.json');

  while(await file.exists()) {
    index++;
    file = File('${documentsDirectory.path}/norris_joke$index.json');
  }

  await file.create();

  await file.writeAsString(jsonEncode(joke.toJson()));
}

Future<List<NorrisJoke>> LoadAllJokesFromStorage() async {
  //Save is not implemented on web
  if(kIsWeb)
    return [];

  List<NorrisJoke> norrisJokesList = [];
  int index = 1;

  final documentsDirectory = await getApplicationDocumentsDirectory();
  File file = File('${documentsDirectory.path}/norris_joke$index.json');

  while(await file.exists()) {
    final content =  json.decode(await file.readAsString());
    norrisJokesList.add(NorrisJoke.fromJson(content));
    index++;
    file = File('${documentsDirectory.path}/norris_joke$index.json');
  }

  return norrisJokesList;
}