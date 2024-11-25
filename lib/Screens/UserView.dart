import 'package:flutter/material.dart';
import 'package:wanderrush/Screens/HomePromotor.dart';
import 'package:wanderrush/Screens/PerfilLugar.dart';
import 'package:wanderrush/Screens/ChatPromotor.dart';
import 'package:wanderrush/Screens/PostScreenPromotor.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    Color colorn = const Color(0xFFF6F7F2);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation:1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDAD3CC),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10.0),
                  suffixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: 'Buscar...',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/profile.png'),
                        radius: 30,
                      ),
                      title: const Text(
                        'Seol',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Hola',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPromotor(),
                          ),
                        );
                      },
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'Eliminar chat') {
                            print('Eliminar chat');
                          } else if (value == 'Ver perfil') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Perfillugar(),
                              ),
                            );
                          } else if (value == 'Dejar de seguir') {
                            print('Dejar de seguir');
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem<String>(
                              value: 'Eliminar chat',
                              child: Text('Eliminar chat'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Ver perfil',
                              child: Text('Ver perfil'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Dejar de seguir',
                              child: Text('Dejar de seguir'),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: colorn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, color: Colors.black54, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePromotor(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_box_outlined, color: Colors.black54, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostScreenPromotor(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.people_alt_outlined, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserView(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/lugar1.png'),
                radius: 18,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Perfillugar(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
