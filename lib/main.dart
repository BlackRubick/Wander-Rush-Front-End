import 'package:flutter/material.dart';
import 'package:wanderrush/screens/homebefore.dart';
import 'package:wanderrush/screens/login.dart';
import 'package:wanderrush/screens/register.dart';
import 'package:wanderrush/screens/MainNavigation.dart';
import 'Screens/Places.dart';
import 'Screens/AddPersonView.dart';
import 'Screens/chatbot.dart';
import 'Screens/PostScreen.dart';
import 'Screens/VistaLugaresApp.dart';
import 'Screens/VistasResenas.dart';
import 'Screens/ChatFriend.dart';
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
        "/chatbot" :  (context) => const ChatbotScreen(),
        "/postscreen" : (context) => const PostScreen(),
        '/vistalugaresapp': (context) => VistaLugaresApp(), // Asegúrate de que esta sea la pantalla correspondiente
        "/vistaresena" :  (context) => VistaResenas(),
        "/chatFriend" :  (context) => ChatFriend(),
      },
    );
  }
}
