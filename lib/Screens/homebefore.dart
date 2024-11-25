import 'package:flutter/material.dart';
//import 'package:wanderrush/screens/login.dart';
import 'package:wanderrush/Screens/HomePromotor.dart';

class HomeBefore extends StatelessWidget {
  const HomeBefore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: -30,
            top: -60,
            child: Container(
              width: 145,
              height: 152,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5F5C58),
              ),
            ),
          ),
          Positioned(
            left: -200,
            top: 560,
            child: Container(
              width: 420,
              height: 420,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5F5C58),
              ),
            ),
          ),
          Positioned(
            right: -320,
            top: -150,
            child: Container(
              width: 455,
              height: 425,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5F5C58),
              ),
            ),
          ),
          Positioned(
            right: -60,
            bottom: 150,
            child: Container(
              width: 145,
              height: 152,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5F5C58),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -100),
                    child: Image.asset(
                      'assets/images/WanderRushLogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Bienvenido a Wander Rush, donde podrás encontrar y compartir nuevas experiencias',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePromotor(),//
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 141, 111, 1),
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Comenzar',
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
