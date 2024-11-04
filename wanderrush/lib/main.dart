import 'package:flutter/material.dart';
import 'package:wanderrush/Screens/ChatFriend.dart';
import 'package:wanderrush/screens/homebefore.dart';
import 'package:wanderrush/screens/login.dart';
import 'package:wanderrush/screens/register.dart'; 
import 'package:wanderrush/screens/home.dart'; 
import 'package:wanderrush/screens/chatbot.dart'; 
import 'package:wanderrush/screens/historyscreen.dart'; 
import 'package:wanderrush/screens/PeopleView.dart'; 
import "package:wanderrush/Screens/profile.dart";
import "package:wanderrush/Screens/places.dart";
import "package:wanderrush/Screens/EditProfile.dart";
import 'package:wanderrush/Screens/SettingsScreen.dart';
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
      initialRoute: '/', 
      routes: {
        '/': (context) => const HomeBefore(),
        '/login': (context) => const LoginPage(), 
        '/register': (context) => const RegisterScreen(),
        "/places" : (context) => const Places(),
        '/home': (context) => const Home(), 
        '/chatbot': (context) => const ChatbotScreen(),
        '/history': (context) => const HistoryScreen(),
        '/peopleview': (context) => const  PeopleView(),
        '/chatFriend': (context) => const  ChatFriend(),
        "/profle" : (context) => const Profile(),
        "/editProfile" : (context) => const Editperfil(),
        "/SettingsScreen": (context) => const SettingScreen(),

      },
    );
  }
}
