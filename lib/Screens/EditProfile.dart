import 'package:flutter/material.dart';

class Editperfil extends StatelessWidget {
    const Editperfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Nombre:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              initialValue: 'Seoul', 
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Gustos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              initialValue: 'Arte y Música', 
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                    
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEF9A9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
