import 'package:flutter/material.dart';
import 'package:wanderrush/screens/homebefore.dart';
import 'package:wanderrush/screens/login.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:wanderrush/screens/register.dart'; // Asegúrate de que esta ruta sea correcta

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
      },
    );
  }
}
