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

///Loads three jokes in a row
Future<List<NorrisJoke>> loadThreeJokes() async {
  List<NorrisJoke> jokes = [
    await loadNorrisJoke(),
    await loadNorrisJoke(),
    await loadNorrisJoke()
  ];
  return jokes;
}

///Gets a random picture of Chuck Norris from assets
ImageProvider getRandomNorrisImage() {
  int randInd = Random().nextInt(10) + 1;
  return AssetImage("assets/images/chuck$randInd.png");
}

ImageProvider getNorrisImageByIndex(int index) {
  return AssetImage("assets/images/chuck$index.png");
}