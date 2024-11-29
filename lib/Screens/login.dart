import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
 
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // URL de tu API
  final String _apiUrl = "http://10.0.2.2:8000/api/v1/login";  // Cambia esto a la URL de tu API


  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Verificar que el email y la contraseña no estén vacíos
    if (email.isEmpty || password.isEmpty) {
      // Mostrar un mensaje si los campos están vacíos
      _showErrorDialog("Por favor, ingresa tu correo y contraseña.");
      return;
    }

    // Crear el cuerpo de la petición
    final Map<String, String> loginData = {
      'email': email,
      'password': password,
    };

    try {
      // Haciendo la solicitud POST
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginData),
      );

      // Mostrar el cuerpo de la respuesta
      print("Respuesta de la API: ${response.body}");

      // Comprobar el código de respuesta
      if (response.statusCode == 200) {
        print("Inicio de sesión exitoso.");
        // Navegar a la página de inicio
        Navigator.pushNamed(context, '/home');
      } else {
        // Si la respuesta no es exitosa, mostrar un mensaje de error
        final responseBody = json.decode(response.body);
        print("Error en la respuesta: $responseBody");
        _showErrorDialog(responseBody['detail'] ?? "Error desconocido.");
      }
    } catch (e) {
      // Si ocurre un error en la conexión, mostrar el error
      print("Error en la conexión: $e");
      _showErrorDialog("No se pudo conectar con el servidor.");
    }
  }

  // Función para mostrar un mensaje de error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Correo electrónico:', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Contraseña:', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(227, 141, 111, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes una cuenta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Crear cuenta',
                        style: TextStyle(color: Color.fromRGBO(227, 141, 111, 1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
