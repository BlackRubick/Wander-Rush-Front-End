import 'package:flutter/material.dart';
import 'package:wanderrush/screens/homebefore.dart';
import 'package:wanderrush/screens/login.dart';
import 'package:wanderrush/screens/register.dart';
import 'package:wanderrush/screens/MainNavigation.dart';
import 'Screens/Places.dart';
import 'Screens/AddPersonView.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander Rush',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/homebefore', // Pantalla inicial
      routes: {
        '/homebefore': (context) => const HomeBefore(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MainNavigation(),
        "/places" : (context) => const Places(),
        "/addPerson": (context) => const AddPersonView(),
      },
    );
  }
}
