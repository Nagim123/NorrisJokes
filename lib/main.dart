import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chuck_norris/page_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const NorrisApp());
}

//Main application widget
class NorrisApp extends StatelessWidget {
  const NorrisApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      theme: ThemeData.dark(),
      home: FlexiblePages(),
    );
  }
}
