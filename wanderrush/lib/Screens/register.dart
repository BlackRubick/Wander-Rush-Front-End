import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _termsAccepted = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false; // Para mostrar un indicador de carga

  bool _isButtonEnabled() {
    return _termsAccepted && _emailError == null && _passwordError == null;
  }

  void _validateForm() {
    setState(() {
      _emailError = null;
      _passwordError = null;

      // Validación de correo electrónico
      final email = _emailController.text;
      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@hotmail\.[a-zA-Z]{2,}$').hasMatch(email)) {
        _emailError = 'Por favor ingrese un correo válido de hotmail.';
      }

      // Comparar contraseñas
      if (_passwordController.text != _confirmPasswordController.text) {
        _passwordError = 'Las contraseñas no coinciden.';
      }
    });
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

final url = Uri.parse('http://10.0.2.2:8000/register'); // URL de la API para emulador Android
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Registro exitoso
      Navigator.pushNamed(context, '/login');
    } else {
      // Error en el registro
      final errorMessage = jsonDecode(response.body)['error'] ?? 'Error al registrar';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50), 
                Image.asset('assets/images/avatar2.png', height: 100),
                const SizedBox(height: 24),
                const Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Campo para Nombre de Usuario
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nombre de Usuario',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        hintText: '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Campo para Correo Electrónico
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Correo Electrónico',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        hintText: '',
                        errorText: _emailError,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Campo para Contraseña
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contraseña',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        hintText: '',
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Campo para Confirmar Contraseña
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirmar Contraseña',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(227, 141, 111, 1)),
                        ),
                        hintText: '',
                        errorText: _passwordError,
                        suffixIcon: const Icon(Icons.visibility),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'He leído y acepto los términos y condiciones de uso',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isButtonEnabled() ? () {
                    _validateForm();
                    if (_isButtonEnabled()) _registerUser();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled() 
                        ? const Color.fromRGBO(227, 141, 111, 1) 
                        : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading 
                      ? CircularProgressIndicator(color: Colors.white) 
                      : const Text('Registrar', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Ya tienes una cuenta?'),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      child: const Text('Iniciar Sesión'),
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
