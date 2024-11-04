import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatFriend extends StatefulWidget {
  const ChatFriend({super.key});

  @override
  _ChatFriendState createState() => _ChatFriendState();
}

class _ChatFriendState extends State<ChatFriend> {
  final List<Map<String, String>> messages = []; // Lista de mensajes
  final TextEditingController _controller = TextEditingController();
  bool _showEmojiPicker = false; // Estado para el selector de emojis

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'sender': 'Seol', // Puedes modificar esto según el remitente
          'image': 'assets/images/avatar.png', // Ruta de la imagen de perfil
        });
        _controller.clear(); // Limpiar el campo de texto
      });
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker; // Alternar el estado del selector de emojis
    });
  }

  void _onEmojiSelected(Emoji emoji) {
    _controller.text += emoji.emoji; // Agregar emoji al campo de texto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'), // Ruta de la imagen de perfil
              radius: 25, // Aumentar el tamaño del avatar
            ),
            const SizedBox(width: 18), // Aumentar el espacio entre imagen y texto
            const Text(
              'Seol', // Nombre del usuario
              style: TextStyle(
                fontSize: 24, // Aumentar el tamaño del texto
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6F4C3E), // Color del AppBar
        elevation: 0, // Eliminar sombra
        automaticallyImplyLeading: false, // Eliminar icono de flecha de regresar
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alineación de la imagen y el texto
                    children: [
                      // Imagen de perfil
                      CircleAvatar(
                        backgroundImage: AssetImage(messages[index]['image']!),
                        radius: 20, // Tamaño del avatar
                      ),
                      const SizedBox(width: 10), // Espacio entre imagen y texto
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: messages[index]['sender'] == 'Seol'
                                ? Colors.grey[300] // Color para mensajes de Seol
                                : Color(0xFFE88A73), // Color para mensajes del usuario
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            messages[index]['text']!,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_showEmojiPicker) // Mostrar el selector de emojis si está activo
            SizedBox(
              height: 250, // Altura del selector de emojis
              child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji emoji) {
                  _onEmojiSelected(emoji); // Manejar la selección de emojis
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Icono de emojis
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: _toggleEmojiPicker, // Alternar el selector de emojis
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFDAD3CC), // Color de fondo del campo de texto
                    ),
                  ),
                ),
                // Botón de enviar con fondo circular
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE88A73), // Color del fondo circular
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white), // Ícono de enviar en blanco
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
