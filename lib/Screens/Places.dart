import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wanderrush/Screens/PostScreen.dart'; // Asegúrate de tener la ruta correcta

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  bool showCommunity = true;

  final List<Map<String, dynamic>> preloadedCommunityData = [
    // Nuevas publicaciones de actividades en la comunidad
    {
      'title': 'Rodada en bicicleta',
      'subtitle': 'Hoy a las 5:00 PM saldremos a rodar en bicicleta por el parque central. ¡No faltes!',
      'profileImage': 'assets/images/perfil1.jpg', // Imagen de perfil
      'activityImage': 'assets/images/rodada.jpg', // Imagen de actividad
      'rating': 4.5,
    },
    {
      'title': 'Fútbol en la cancha',
      'subtitle': 'Este sábado a las 3:00 PM vamos a jugar fútbol en el campo de deportes. ¡Trae tus amigos!',
      'profileImage': 'assets/images/persona2.jpg',
      'activityImage': 'assets/images/futbol.jpg',
      'rating': 4.3,
    },
    {
      'title': 'Partido de basquetbol',
      'subtitle': 'Mañana a las 7:00 PM habrá un partido amistoso de basquetbol en el gimnasio local.',
      'profileImage': 'assets/images/perfil3.jpg',
      'activityImage': 'assets/images/basquet.jpg',
      'rating': 4.7,
    },

  ];

  final List<Map<String, dynamic>> _localCommunityPosts = [];

  final List<Map<String, dynamic>> placesData = [
    {
      'title': 'Museo de Arte',
      'subtitle': 'Explora el arte local e internacional.',
      'image': 'assets/images/lugar1.png',
      'rating': 4.0,
    },
    {
      'title': 'Parque Central',
      'subtitle': 'Un lugar tranquilo para pasear y relajarse.',
      'image': 'assets/images/lugar2.png',
      'rating': 4.5,
    },
    {
      'title': 'Café Sol y Luna',
      'subtitle': 'Disfruta de un café en un ambiente acogedor.',
      'image': 'assets/images/lugar3.jpg',
      'rating': 3.8,
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
                  showCommunity = true;
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
                  showCommunity = false;
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
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final newPost = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostScreen()),
              );
              if (newPost != null && newPost is Map<String, dynamic>) {
                setState(() {
                  _localCommunityPosts.add(newPost);
                });
              }
            },
          ),
        ],
      ),
      body: showCommunity ? _buildCommunityView() : _buildPlacesView(),
    );
  }

  Widget _buildCommunityView() {
    final combinedCommunityData = [
      ...preloadedCommunityData,
      ..._localCommunityPosts,
    ];

    return ListView.builder(
      itemCount: combinedCommunityData.length,
      itemBuilder: (context, index) {
        final item = combinedCommunityData[index];
        return CardWithRating(
          title: item['title']!,
          subtitle: item['subtitle']!,
          profileImage: item['profileImage']!,
          activityImage: item['activityImage']!,
          rating: item['rating'] ?? 0.0,
        );
      },
    );
  }

  Widget _buildPlacesView() {
    return ListView.builder(
      itemCount: placesData.length,
      itemBuilder: (context, index) {
        final place = placesData[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/vistalugaresapp',
              arguments: place, // Pasa el lugar seleccionado
            );
          },
          child: CardWithRating(
            title: place['title']!,
            subtitle: place['subtitle']!,
            profileImage: 'assets/images/default_profile.jpg', // Imagen de perfil por defecto
            activityImage: place['image']!,
            rating: place['rating']!,
          ),
        );
      },
    );
  }
}

class CardWithRating extends StatelessWidget {
  final String title;
  final String subtitle;
  final String profileImage;
  final String activityImage;
  final double rating;

  const CardWithRating({
    super.key,
    required this.title,
    required this.subtitle,
    required this.profileImage,
    required this.activityImage,
    this.rating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocalImage = File(activityImage).existsSync();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: File(profileImage).existsSync()
                  ? FileImage(File(profileImage))
                  : AssetImage(profileImage) as ImageProvider,
            ),
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Icon(Icons.more_vert),
          ),
          isLocalImage
              ? Image.file(File(activityImage), errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                })
              : Image.asset(activityImage, errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                }),
          if (rating > 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('$rating'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
