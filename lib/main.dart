import 'package:chuck_norris/api_interactions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chuck_norris/page_manager.dart';
import 'firebase_options.dart';
import 'filter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  //Required for firebase
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //Initializing firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //Set up Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    //Set up filter
    filteredCategories = await loadCategories();
  } catch (_) {
    runApp(const NoConnectionWidget());
    return;
  }
  //Run app
  runApp(const NorrisApp());
}

///Main application widget
class NorrisApp extends StatelessWidget {
  const NorrisApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      theme: ThemeData.dark(),
      home: const FlexiblePages(),
    );
  }
}

///If user load application without internet connection
class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: const Text("Chuck Norris Jokes"),),
        body: const Center(child: Text("Connection error!", style: TextStyle(fontSize: 20),)),
      ),
    );
  }
}
