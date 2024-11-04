import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seol'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Sección de perfil
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(height: 8),
                Text(
                  'Seol',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Gustos:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  'Arte y Música',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('0'),
                        Text('Seguidores'),
                      ],
                    ),
                    SizedBox(width: 32),
                    Column(
                      children: [
                        Text('0'),
                        Text('Seguidos'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Acción para editar perfil
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        // Acción para configuración
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          // Sección de publicaciones
          Expanded(
            child: ListView.builder(
              itemCount: 2, // número de publicaciones
              itemBuilder: (context, index) {
                return PostCard();
              },
            ),
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFDAD3CC),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/images/post.png'),
            ),
            label: '',
          ),
        ],
        currentIndex: 4, // Índice de la pestaña activa
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        onTap: (index) {
          // Navegación en la barra inferior
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            // Acción para la búsqueda
          } else if (index == 2) {
            // Acción para agregar publicación
          } else if (index == 3) {
            Navigator.pushNamed(context, '/people');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile'); // Acción para la vista de perfil
          }
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            title: Text('Jay B'),
            subtitle: Text('Un agradable lugar @b'),
            trailing: Icon(Icons.more_vert),
          ),
          Image.asset('assets/images/post.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined),
                SizedBox(width: 16),
                Icon(Icons.send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
