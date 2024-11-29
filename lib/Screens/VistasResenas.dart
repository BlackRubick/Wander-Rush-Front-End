import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete

class VistaResenas extends StatefulWidget {
  const VistaResenas({super.key});

  @override
  _VistaResenasState createState() => _VistaResenasState();
}

class _VistaResenasState extends State<VistaResenas> {
  final List<Map<String, String>> comentarios = []; // Lista para guardar los comentarios
  final TextEditingController _comentarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarComentarios(); // Cargar los comentarios cuando la vista se inicie
  }

  // Cargar los comentarios desde shared_preferences
  _cargarComentarios() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedComentarios = prefs.getStringList('comentarios');
    if (storedComentarios != null) {
      setState(() {
        // Convertir cada comentario guardado en un mapa
        comentarios.addAll(storedComentarios
            .map((comentario) => {'texto': comentario})
            .toList());
      });
    }
  }

  // Guardar los comentarios en shared_preferences
  _guardarComentarios() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> comentariosTexto = comentarios.map((comentario) => comentario['texto']!).toList();
    prefs.setStringList('comentarios', comentariosTexto); // Guardar lista de comentarios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Reseñas',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Encabezado de la pantalla
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Opiniones de los visitantes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Lista de comentarios
          Expanded(
            child: ListView.builder(
              itemCount: comentarios.length, // Número de comentarios en la lista
              itemBuilder: (context, index) {
                // Construir cada comentario en la lista
                return _buildComentario(
                  nombre: 'BlackRubick', // Nombre de usuario fijo
                  comentario: comentarios[index]['texto']!, // Usar el comentario agregado
                  imagenUrl: 'https://scontent.ftgz2-1.fna.fbcdn.net/v/t39.30808-6/441461730_2770491469764689_667352005712812379_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeEA2aFs1vshGOC6QKX7WlqNcVKzGwYmUXdxUrMbBiZRd_pDz6v8rWFYYsYGgpchIad_iyZDH-aqLwH_i2WOZvV5&_nc_ohc=2zBFfILz-qUQ7kNvgFHsGVq&_nc_zt=23&_nc_ht=scontent.ftgz2-1.fna&_nc_gid=Ak1bMRYX4ErNNyOE9KhETav&oh=00_AYBzQzfwrOJQWmfVvR2epAXiOAxV_NAtif0M4q6n4MbfJQ&oe=674F9276',  // Ruta de la imagen local
                );
              },
            ),
          ),

          // Barra para escribir un nuevo comentario
          _buildComentarioBar(),
        ],
      ),
    );
  }

  // Widget para construir un comentario individual
  Widget _buildComentario({required String nombre, required String comentario, required String imagenUrl}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imagenUrl),
      ),
      title: Text(nombre, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(comentario), // Mostrar el comentario
    );
  }

  // Barra de texto para agregar un nuevo comentario
  Widget _buildComentarioBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _comentarioController, // Controlador para capturar el texto
              decoration: InputDecoration(
                hintText: 'Escribe un comentario...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              if (_comentarioController.text.isNotEmpty) {
                // Si hay texto en el campo, agregar el comentario a la lista
                setState(() {
                  comentarios.add({
                    'texto': _comentarioController.text, // Agregar el comentario
                  });
                  _comentarioController.clear(); // Limpiar el campo de texto
                  _guardarComentarios(); // Guardar los comentarios localmente
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Comentario enviado')),
                );
              }
            },
            icon: Icon(Icons.send, color: Colors.blue), // Icono de enviar
          ),
        ],
      ),
    );
  }
}
