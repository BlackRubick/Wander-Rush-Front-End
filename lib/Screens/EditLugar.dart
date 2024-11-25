import 'dart:io';
import 'dart:ui'; // Para BackdropFilter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderrush/Screens/PerfilLugar.dart';

class EditLugar extends StatefulWidget {
  const EditLugar({super.key});

  @override
  _EditLugarState createState() => _EditLugarState();
}

class _EditLugarState extends State<EditLugar> {
  Color colorn = Color(0xFFF6F7F2);
  File? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  // Método para seleccionar la imagen
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              SizedBox(height: 24),
              Text(
                'Nombre del lugar:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Ingresa el nombre',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Descripción:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Escribe una descripción',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Dirección',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _direccionController,
                decoration: InputDecoration(
                  hintText: 'Escribe una dirección',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Horario:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _horarioController,
                decoration: InputDecoration(
                  hintText: 'Escribe un horario',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Teléfono:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(
                  hintText: 'Escribe un número de teléfono',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagen en círculo con opción para editar
        Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _selectedImage != null
                          ? FileImage(_selectedImage!) // Imagen seleccionada
                          : AssetImage('assets/images/lugar1.png')
                      as ImageProvider, // Imagen predeterminada
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Botón para editar la imagen
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 160), // Espacio entre la imagen y los botones
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                /*if (_selectedImage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Cambios guardados.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selecciona una imagen antes de guardar.')),
                  );
                }*/
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Perfillugar(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFCDD2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                /*setState(() {
                  _selectedImage = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cambios descartados.')),
                );*/
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Perfillugar(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFBE9E7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
