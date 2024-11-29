import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatFriend extends StatefulWidget {
  const ChatFriend({super.key});

  @override
  _ChatFriendState createState() => _ChatFriendState();
}

class _ChatFriendState extends State<ChatFriend> {
  final List<Map<String, String>> messages = [
    {
      'text': 'Hola',
      'sender': 'Paco',
      'image': 'assets/images/paco.png', // Ajusta la ruta de la imagen
    }
  ]; // Mensaje inicial enviado por Paco
  final TextEditingController _controller = TextEditingController();
  bool _showEmojiPicker = false;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'sender': 'Tú', // Los mensajes enviados serán de "Tú"
          'image': 'assets/images/avatar_user.png', // Ajusta la imagen del usuario
        });
        _controller.clear();
      });
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _onEmojiSelected(Emoji emoji) {
    _controller.text += emoji.emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/paco.png'), // Imagen de Paco
              radius: 25,
            ),
            const SizedBox(width: 18),
            const Text(
              'Paco', // Nombre del amigo en el chat
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6F4C3E),
        elevation: 0,
        automaticallyImplyLeading: false,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(messages[index]['image']!),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: messages[index]['sender'] == 'Paco'
                                ? Colors.grey[300] // Mensajes de Paco
                                : const Color(0xFFE88A73), // Mensajes del usuario
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
          if (_showEmojiPicker)
            SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji emoji) {
                  _onEmojiSelected(emoji);
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: _toggleEmojiPicker,
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
                      fillColor: const Color(0xFFDAD3CC),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE88A73),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
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
