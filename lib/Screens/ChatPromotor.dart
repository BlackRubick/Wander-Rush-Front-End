import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatPromotor extends StatefulWidget {
  const ChatPromotor({super.key});

  @override
  _ChatPromotorState createState() => _ChatPromotorState();
}

class _ChatPromotorState extends State<ChatPromotor> {
  final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _showEmojiPicker = false;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'sender': 'Museo del Café de Chiapas',
          'image': 'assets/images/lugar1.png',
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
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: 22,
            ),
            const SizedBox(width: 18),
            const Text(
              'Seol',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF605C58),
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
                final isOwnMessage =
                    messages[index]['sender'] == 'Museo del Café de Chiapas';

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: isOwnMessage
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar para mensajes recibidos
                      if (!isOwnMessage) ...[
                        CircleAvatar(
                          backgroundImage: AssetImage(messages[index]['image']!),
                          radius: 20,
                        ),
                        const SizedBox(width: 10),
                      ],
                      // Mensaje
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7, // 70% del ancho
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: isOwnMessage
                              ? Color(0xFFE88A73)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: isOwnMessage
                                ? const Radius.circular(10.0)
                                : const Radius.circular(0.0),
                            bottomRight: isOwnMessage
                                ? const Radius.circular(0.0)
                                : const Radius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          messages[index]['text']!,
                          style: const TextStyle(fontSize: 16.0,fontFamily: 'Poppins-Regular',),
                        ),
                      ),
                      // Espacio entre mensaje y avatar del remitente
                      if (isOwnMessage) const SizedBox(width: 10),
                      // Avatar para mensajes propios
                      if (isOwnMessage)
                        CircleAvatar(
                          backgroundImage: AssetImage(messages[index]['image']!),
                          radius: 20,
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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFDAD3CC),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.black, // Color del icono
                    ),
                    onPressed: _toggleEmojiPicker,
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...', hintStyle: TextStyle(fontFamily: 'Poppins-Regular',),
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
