import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  bool showCommunity = true;
  int _currentIndex = 0; // Índice inicial del BottomNavigationBar

  final List<Map<String, dynamic>> placesData = [
    {
      'title': 'Parque Central',
      'subtitle': 'Un lugar tranquilo para pasear y relajarse.',
      'image': 'assets/images/lugar2.png',
      'rating': 4.5,
    },
    {
      'title': 'Museo de Arte',
      'subtitle': 'Explora el arte local e internacional.',
      'image': 'assets/images/lugar1.png',
      'rating': 4.0,
    },
    {
      'title': 'Café Sol y Luna',
      'subtitle': 'Disfruta de un café en un ambiente acogedor.',
      'image': 'assets/images/lugar3.jpg',
      'rating': 3.8,
    },
  ];

  final List<Map<String, dynamic>> communityData = [
    {
      'title': 'Jay B',
      'subtitle': 'Un agradable lugar para compartir ideas.',
      'image': 'assets/images/post.png',
      'rating': 4.2,
    },
    {
      'title': 'Anna Smith',
      'subtitle': 'Disfruta del arte en compañía.',
      'image': 'assets/images/profile.png',
      'rating': 4.7,
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
      ),
      body: showCommunity ? _buildCommunityView() : _buildPlacesView(),
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
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/Places');
              break;
            case 2:
              Navigator.pushNamed(context, '/post');
              break;
            case 3:
              Navigator.pushNamed(context, '/peopleview');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildCommunityView() {
    return ListView.builder(
      itemCount: communityData.length,
      itemBuilder: (context, index) {
        final item = communityData[index];
        return CardWithRating(
          title: item['title']!,
          subtitle: item['subtitle']!,
          imageAsset: item['image']!,
          rating: item['rating']!,
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
              arguments: place,
            );
          },
          child: CardWithRating(
            title: place['title']!,
            subtitle: place['subtitle']!,
            imageAsset: place['image']!,
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
  final String imageAsset;
  final double rating;

  const CardWithRating({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.rating,
  });

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
