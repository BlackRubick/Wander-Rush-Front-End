import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  // Método para lanzar la URL
  Future<void> _launchURL() async {
    const String url = 'https://wanderrush.testsoftware.dev/';
    final Uri uri = Uri.parse(url); // Usamos Uri.parse para mayor compatibilidad
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Modo de navegador externo
    } else {
      throw 'No se puede abrir la URL $url';
    }
  }

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
                    // Aquí va la acción para editar perfil
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Eliminar cuenta'),
                  onTap: () {
                    // Aquí va la acción para eliminar cuenta
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Términos y condiciones'),
                  onTap: () {
                    print("Términos y condiciones clickeado");
                    _launchURL(); // Llama a la función para abrir el enlace
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
                // Acción de cerrar sesión
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
