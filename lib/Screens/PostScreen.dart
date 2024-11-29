import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  List<Map<String, dynamic>> _posts = [];
  double _rating = 0.0; // Valor inicial del rating

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? postsJson = prefs.getString('posts');
    if (postsJson != null) {
      setState(() {
        _posts = List<Map<String, dynamic>>.from(json.decode(postsJson));
      });
    }
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String postsJson = json.encode(_posts);
    await prefs.setString('posts', postsJson);
  }

Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    setState(() {
      _selectedImage = File(image.path);
    });
  } else {
    // Aquí puedes agregar una lógica adicional si no se selecciona una imagen
    print('No se seleccionó ninguna imagen');
  }
}



 void _addPost() async {
  final title = _titleController.text;
  final description = _descriptionController.text;

  if (title.isEmpty || description.isEmpty || _selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Por favor, llena todos los campos y selecciona una imagen')),
    );
    return;
  }

final post = {
  'title': title,
  'description': description,
  'image': _selectedImage?.path ?? '', // Usar '' si _selectedImage es null
};


  setState(() {
    _posts.add(post);
    _titleController.clear();
    _descriptionController.clear();
    _selectedImage = null;
  });

  await _savePosts();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('¡Publicación guardada!')),
  );

  Navigator.pop(context, post); // Retorna la publicación creada
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/yo.jpg'),
            ),
            SizedBox(width: 8),
            Text(
              'BlackRubick',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _addPost,
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFE88A73),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Guardar'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de título
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFDAD3CC),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Agregue un título...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(height: 16),
            // Campo de descripción
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFDAD3CC),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Agregue una descripción...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 16),
            // Selector de imagen
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFF9E5B8),
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedImage == null
                    ? Icon(Icons.add_photo_alternate, size: 40, color: Color(0xFFE88A73))
                    : null,
              ),
            ),
            SizedBox(height: 16),
            // Slider para calificación
            Text("Calificación: ${_rating.toStringAsFixed(1)}"),
            Slider(
              value: _rating,
              min: 0.0,
              max: 5.0,
              divisions: 5,
              label: _rating.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            SizedBox(height: 16),
            // Lista de publicaciones
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.file(
                        File(post['image']),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(post['title']),
                      subtitle: Text(post['description']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
