import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'norris_joke.dart';
import 'dart:convert';
import 'dart:math';

/*
  This file is responsible for all API interactions
 */
///Loading one joke from Norris API by 'http'
Future<NorrisJoke> loadNorrisJoke() async {
  final response =
      await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

  if (response.statusCode == 200) {
    NorrisJoke joke = NorrisJoke.fromJson(jsonDecode(response.body));
    joke.imageIndex = Random().nextInt(10) + 1;
    return joke;
  }
  throw Exception("Failed to load a joke!");
}

Future<NorrisJoke> loadNorrisJokeByCategory(List<String> categories) async {
  if(categories.isEmpty) {
    return await loadNorrisJoke();
  }

  final randomCategory = categories[Random().nextInt(categories.length)];
  
  final response =
  await http.get(Uri.parse('https://api.chucknorris.io/jokes/random?category=$randomCategory'));

  if (response.statusCode == 200) {
    NorrisJoke joke = NorrisJoke.fromJson(jsonDecode(response.body));
    joke.imageIndex = Random().nextInt(10) + 1;
    return joke;
  }
  throw Exception("Failed to load a joke!");
}

///Loads available categories
Future<List<String>> loadCategories() async {
  final response =
      await http.get(Uri.parse('https://api.chucknorris.io/jokes/categories'));

  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    List<String> result = [];
    for(var element in parsedJson) {
      result.add(element);
    }
    return result;
  }
  throw Exception("Failed to load categories!");
}

///Loads three jokes in a row
Future<List<NorrisJoke>> loadThreeJokes() async {
  List<NorrisJoke> jokes = [
    await loadNorrisJoke(),
    await loadNorrisJoke(),
    await loadNorrisJoke()
  ];
  return jokes;
}

///Loads three jokes with specified category in a row
Future<List<NorrisJoke>> loadThreeJokesByCategory(List<String> categories) async {
  List<NorrisJoke> jokes = [
    await loadNorrisJokeByCategory(categories),
    await loadNorrisJokeByCategory(categories),
    await loadNorrisJokeByCategory(categories)
  ];
  return jokes;
}

///Gets a random picture of Chuck Norris from assets
ImageProvider getRandomNorrisImage() {
  int randInd = Random().nextInt(10) + 1;
  return AssetImage("assets/images/chuck$randInd.png");
}

///Gets image of Chuck Norris with specified index
ImageProvider getNorrisImageByIndex(int index) {
  return AssetImage("assets/images/chuck$index.png");
}