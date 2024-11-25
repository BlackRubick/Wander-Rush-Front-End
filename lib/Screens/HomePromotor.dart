import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:wanderrush/Screens/UserView.dart';
import 'package:wanderrush/Screens/PerfilLugar.dart';
import 'package:wanderrush/Screens/PostScreenPromotor.dart';

class HomePromotor extends StatefulWidget {
  const HomePromotor({super.key});

  @override
  _HomePromotorState createState() => _HomePromotorState();
}

class _HomePromotorState extends State<HomePromotor> {
  Color colorn = Color(0xFFF6F7F2);

  final int _currentIndex = 0; // Índice inicial del BottomNavigationBar
  final ImagePicker _picker = ImagePicker();

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

  final List<Map<String, String>> stories = [];

  Future<void> _addStory() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Seleccionar de la galería'),
              onTap: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    stories.add({
                      'image': pickedFile.path,
                      'label': '',
                    });
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Usar la cámara'),
              onTap: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    stories.add({
                      'image': pickedFile.path,
                      'label': ' ',
                    });
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildStoriesSection(), // Historias
          Expanded(child: _buildCommunityView()), // Vista de la comunidad
        ],
      ),
      bottomNavigationBar: Container(
        color: colorn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black, size: 30),
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
              icon: Icon(Icons.add_box_outlined, color: Colors.black54, size: 30),
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
              icon: Icon(Icons.people_alt_outlined, color: Colors.black54, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserView(),
                  ),
                );
              },
            ),
            IconButton(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/lugar1.png'), radius: 18,),
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

  Widget _buildStoriesSection() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Stack(
        children: [
          ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final story = stories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoryFullView(imagePath: story['image']!),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: story['image']!.contains('assets')
                              ? AssetImage(story['image']!) as ImageProvider
                              : FileImage(File(story['image']!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      story['label']!,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blue, size: 28),
              onPressed: _addStory,
            ),
          ),
        ],
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            title: Text(title, style: TextStyle(fontFamily:'Poppins', fontWeight: FontWeight.w500,),),
            subtitle: Text(subtitle,style: TextStyle(fontFamily:'Poppins',),),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.asset(imageAsset),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text('$rating'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoryFullView extends StatelessWidget {
  final String imagePath;

  const StoryFullView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promoción', style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: imagePath.contains('assets')
            ? Image.asset(imagePath)
            : Image.file(File(imagePath)),
      ),
    );
  }
}
