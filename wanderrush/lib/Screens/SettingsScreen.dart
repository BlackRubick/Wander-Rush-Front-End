import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Editar perfil'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Eliminar cuenta'),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Términos y condiciones'),
                  onTap: () {
                  },
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
              },
              icon: Icon(Icons.logout),
              label: Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDAD3CC),
                foregroundColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
