import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  bool showCommunity = true; // Variable de estado para controlar la vista actual

  // Lista de datos para la sección de Lugares
  final List<Map<String, dynamic>> placesData = [
    {
      'title': 'Parque Central',
      'subtitle': 'Un lugar tranquilo para pasear y relajarse.',
      'image': 'assets/images/lugar2.png',
      'likes': 150,
    },
    {
      'title': 'Museo de Arte',
      'subtitle': 'Explora el arte local e internacional.',
      'image': 'assets/images/lugar1.png',
      'likes': 85,
    },
    {
      'title': 'Café Sol y Luna',
      'subtitle': 'Disfruta de un café en un ambiente acogedor.',
      'image': 'assets/images/lugar3.jpg',
      'likes': 26,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  showCommunity = true; // Mostrar comunidad
                });
              },
              child: Text(
                'Comunidad',
                style: TextStyle(
                  color: showCommunity ? Colors.black : Colors.black54,
                  fontWeight: showCommunity ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  showCommunity = false; // Mostrar lugares
                });
              },
              child: Text(
                'Lugares',
                style: TextStyle(
                  color: !showCommunity ? Colors.black : Colors.black54,
                  fontWeight: !showCommunity ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      body: showCommunity ? _buildCommunityView() : _buildPlacesView(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFF5F3ED),
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
            Navigator.pushNamed(context, '/places'); // Acción para la vista de Lugares
          }
        },
      ),
    );
  }

  // Vista de Comunidad
  Widget _buildCommunityView() {
    return ListView.builder(
      itemCount: 2, // Número de publicaciones de comunidad
      itemBuilder: (context, index) {
        return PostCard(
          title: 'Jay B',
          subtitle: 'Un agradable lugar @b',
          imageAsset: 'assets/images/post.png',
          likes: 100,
        );
      },
    );
  }

  // Vista de Lugares
  Widget _buildPlacesView() {
    return ListView.builder(
      itemCount: placesData.length, // Número de lugares en la lista
      itemBuilder: (context, index) {
        final place = placesData[index];
        return PostCard(
          title: place['title']!,
          subtitle: place['subtitle']!,
          imageAsset: place['image']!,
          likes: place['likes']!,
        );
      },
    );
  }
}

// Tarjeta de publicación
class PostCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final int likes;

  const PostCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.likes,
  }) : super(key: key);

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
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Icon(Icons.more_vert),
          ),
          Image.asset(imageAsset),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 4),
                Text('$likes'),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
