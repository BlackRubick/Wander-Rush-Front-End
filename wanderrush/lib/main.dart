import 'package:flutter/material.dart';
import 'package:wanderrush/screens/homebefore.dart';
import 'package:wanderrush/screens/login.dart';
import 'package:wanderrush/screens/register.dart'; 
import 'package:wanderrush/screens/home.dart'; 
import 'package:wanderrush/screens/chatbot.dart'; 
import 'package:wanderrush/screens/historyscreen.dart'; 

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
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomeBefore(),
        '/login': (context) => const LoginPage(), 
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const Home(), 
        '/chatbot': (context) => const ChatbotScreen(),
        '/history': (context) => const HistoryScreen(),

      },
    );
  }
}
