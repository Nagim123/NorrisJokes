import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'norris_joke.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';

enum SaveModes { storage, firestore }

ValueNotifier<SaveModes> saveMode =
    ValueNotifier<SaveModes>(SaveModes.firestore);

///Common function for joke saving
Future<void> saveJoke(NorrisJoke joke) async {
  if (saveMode.value == SaveModes.storage) {
    await saveJokeToStorage(joke);
  } else if (saveMode.value == SaveModes.firestore) {
    await saveJokeToDatabase(joke);
  } else {
    throw Exception("Unimplemented save/load mode!");
  }
}

///Common function for joke loading
Future<List<NorrisJoke>> loadAllJokes() async {
  if (saveMode.value == SaveModes.storage) {
    return await loadAllJokesFromStorage();
  } else if (saveMode.value == SaveModes.firestore) {
    return await loadAllJokesFromDatabase();
  } else {
    throw Exception("Unimplemented save/load mode!");
  }
}

///Common function for joke deleting
Future<void> deleteJoke(NorrisJoke joke) async {
  if (saveMode.value == SaveModes.storage) {
    await deleteJokeFromStorage(joke);
  } else if (saveMode.value == SaveModes.firestore) {
    await deleteJokeFromDatabase(joke);
  } else {
    throw Exception("Unimplemented save/load mode!");
  }
}

///Saves joke to firestore database
Future<void> saveJokeToDatabase(NorrisJoke joke) async {
  var jokeJSON = joke.toJson();
  jokeJSON['imageIndex'] = joke.imageIndex;
  FirebaseFirestore.instance
      .collection('jokes')
      .add({"joke": jsonEncode(jokeJSON)});
}

///Loads all jokes from firestore database
Future<List<NorrisJoke>> loadAllJokesFromDatabase() async {
  final items = await FirebaseFirestore.instance.collection('jokes').get();
  List<NorrisJoke> jokes = [];
  for (var element in items.docs) {
    var jokeJSON = jsonDecode(element.data()["joke"]);
    jokes.add(NorrisJoke.fromJson(jokeJSON));
    jokes.last.imageIndex = jokeJSON["imageIndex"];
  }

  return jokes;
}

///Deletes joke from firestore database
Future<void> deleteJokeFromDatabase(NorrisJoke joke) async {
  final items = await FirebaseFirestore.instance.collection('jokes').get();
  for (var item in items.docs) {
    NorrisJoke currentJoke =
        NorrisJoke.fromJson(jsonDecode(item.data()["joke"]));
    if (currentJoke.id == joke.id) {
      await FirebaseFirestore.instance
          .collection('jokes')
          .doc(item.id)
          .delete();
      break;
    }
  }
}

///Saves joke in file in local storage
Future<void> saveJokeToStorage(NorrisJoke joke) async {
  //This operation is not for web
  if (kIsWeb) return;

  final documentsDirectory = await getApplicationDocumentsDirectory();
  final jokesDirectory = Directory("${documentsDirectory.path}/jokes");
  if (!jokesDirectory.existsSync()) {
    await jokesDirectory.create();
  }
  File file = File('${jokesDirectory.path}/chuck_norris_joke${joke.id}.json');

  await file.create();

  var jsonJoke = joke.toJson();
  jsonJoke["imageIndex"] = joke.imageIndex!;

  await file.writeAsString(jsonEncode(jsonJoke));
}

///Loads joke from storage
Future<List<NorrisJoke>> loadAllJokesFromStorage() async {
  //This operation is not for web
  if (kIsWeb) return [];

  List<NorrisJoke> norrisJokesList = [];

  final documentsDirectory = await getApplicationDocumentsDirectory();
  final jokesDirectory = Directory("${documentsDirectory.path}/jokes");
  if (!jokesDirectory.existsSync()) {
    await jokesDirectory.create();
  }
  List<FileSystemEntity> fileList =
      jokesDirectory.listSync(recursive: true, followLinks: false);
  for (FileSystemEntity entity in fileList) {
    File file = File(entity.path);
    final content = json.decode(await file.readAsString());
    NorrisJoke currentJoke = NorrisJoke.fromJson(content);
    currentJoke.imageIndex = content["imageIndex"];
    norrisJokesList.add(currentJoke);
  }

  return norrisJokesList;
}

///Deletes joke from storage
Future<void> deleteJokeFromStorage(NorrisJoke joke) async {
  //This operation is not for web
  if (kIsWeb) return;

  final documentsDirectory = await getApplicationDocumentsDirectory();
  final jokesDirectory = Directory("${documentsDirectory.path}/jokes");
  if (!jokesDirectory.existsSync()) {
    await jokesDirectory.create();
  }

  List<FileSystemEntity> fileList =
      jokesDirectory.listSync(recursive: true, followLinks: false);
  for (FileSystemEntity entity in fileList) {
    File file = File(entity.path);
    NorrisJoke loadedJoke =
        NorrisJoke.fromJson(json.decode(await file.readAsString()));
    if (joke.value == loadedJoke.value) {
      await file.delete();
      return;
    }
  }
}
