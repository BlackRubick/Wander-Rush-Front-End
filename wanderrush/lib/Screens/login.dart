import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Círculo izquierda arriba
          Positioned(
            left: -30,
            top: -60,
            child: Container(
              width: 145,
              height: 152,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5F5C58),
              ),
            ),
          ),
          // Círculo izquierda abajo
          Positioned(
            left: -200,
            top: 560,
            child: Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5F5C58),
              ),
            ),
          ),
          // Círculo arriba derecha 
          Positioned(
            right: -320,
            top: -150,
            child: Container(
              width: 455,
              height: 425,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5F5C58),
              ),
            ),
          ),
          // Círculo abajo derecha
          Positioned(
            right: -60,
            bottom: 150,
            child: Container(
              width: 145,
              height: 152,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5F5C58),
              ),
            ),
          ),
          // Contenido centrado
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Imagen con transformación
                  Transform.translate(
                    offset: const Offset(0, -100), // Ajusta el valor para mover la imagen hacia arriba
                    child: Image.asset(
                      'assets/images/WanderRushLogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Bienvenido a Wander Rush, donde podras encontrar y compartir nuevas experiencias',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 80), 
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 141, 111, 1), 
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
