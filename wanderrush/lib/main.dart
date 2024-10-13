import 'package:flutter/material.dart';
import 'package:wanderrush/screens/homebefore.dart';
import 'package:wanderrush/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander Rush',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeBefore(), // Inicializa con HomeBefore
    );
  }
}
