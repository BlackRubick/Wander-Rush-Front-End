import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:wanderrush/screens/historyscreen.dart'; 

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<String> _messages = []; 
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHistory(); 
  }

  // Función para cargar el historial
  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _messages = prefs.getStringList('chat_history') ?? []; // enseñamos el historial 
    });
  }

  // Función para guardar el historial
  Future<void> _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('chat_history', _messages); // aqui guardamos el historial 
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
      });

      final userMessage = _controller.text;
      _controller.clear();

      try {
        final response = await http.post(
          Uri.parse('http://10.10.0.29:5001/ask'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'question': userMessage}), 
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          setState(() {
            _messages.add(responseData['answer']); 
          });
        } else {
          setState(() {
            _messages.add('Error: No se pudo conectar con el servidor.');
          });
        }
      } catch (e) {
        setState(() {
          _messages.add('Error: $e');
        });
      }

      // guarda el emnsaje en mi historial
      _saveHistory();
    }
  }

  void _viewHistory() {
    //nos lleva a la vista de el historial 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(messages: _messages),
      ),
    );
  }

  void _clearChat() {
    // se limpia el historial con la x que le puse hasta arriba xd 
    setState(() {
      _messages.clear(); 
    });
    _saveHistory(); // fuarda el historial despues de borrar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'TOKKI CHAT',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 40,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            color: Colors.black,
            onPressed: _viewHistory,
            tooltip: 'Ver Historial',
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            color: Colors.black,
            onPressed: _clearChat,
            tooltip: 'Limpiar Conversación',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: index % 2 == 0
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      if (index % 2 == 0)
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                          radius: 20,
                        ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(_messages[index]),
                        ),
                      ),
                      if (index % 2 != 0) const SizedBox(width: 10),
                      if (index % 2 != 0)
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avatar2.png'),
                          radius: 20,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Mensaje',
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.orange.shade300,
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.white,
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