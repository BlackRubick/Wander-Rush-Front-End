import 'package:flutter/material.dart';

class VistaResenas extends StatelessWidget {
  const VistaResenas({super.key});


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
          // Encabezado
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Opiniones de los visitantes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Lista de reseñas
          Expanded(
            child: ListView(
              children: [
                _buildComentario(
                  nombre: 'Jay B',
                  comentario: 'El aroma de Chiapas @Museo del Café de Chiapas',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
                _buildComentario(
                  nombre: 'Pato',
                  comentario: 'Me gustó mucho el lugar',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
                _buildComentario(
                  nombre: 'César',
                  comentario: 'Me encantó la historia detrás del museo.',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
              ],
            ),
          ),
          // Barra de comentario
          _buildComentarioBar(context),
        ],
      ),
    );
  }

  Widget _buildComentario({required String nombre, required String comentario, required String imagenUrl}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imagenUrl),
      ),
      title: Text(nombre, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(comentario),
    );
  }

  Widget _buildComentarioBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
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
              // Acción para enviar el comentario
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Comentario enviado')),
              );
            },
            icon: Icon(Icons.send, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
