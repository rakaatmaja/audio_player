import 'package:audioplayer/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// https://www.youtube.com/watch?v=BOkyfQ9SMGM&ab_channel=PLANETILMU
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
