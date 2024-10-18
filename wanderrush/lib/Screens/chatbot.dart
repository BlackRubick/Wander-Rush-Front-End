import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wanderrush/screens/historyscreen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isConnected = false; //estado de la conexión

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _checkInternetConnection(); // verificar la conexión al iniciar
    _monitorConnectionChanges(); // iniciar monitoreo de cambios en la conexión
  }

  // verificar el estado de la conexión a Internet
  Future<void> _checkInternetConnection() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    _updateConnectionStatus(hasConnection);
  }

  // monitorear los cambios en la conexión a Internet
  void _monitorConnectionChanges() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      _updateConnectionStatus(hasInternet);
    });
  }

  // actualiza el estado de la conexión
  void _updateConnectionStatus(bool isConnected) {
    setState(() {
      _isConnected = isConnected;
    });
  }

  // cargar el historial de mensajes
  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _messages = prefs.getStringList('chat_history') ?? [];
    });
  }

  // Guardar el historial de mensajes
  Future<void> _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('chat_history', _messages);
  }

  // Enviar un mensaje al bot
  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String userMessage = _controller.text;

      setState(() {
        _messages.add('Usuario: $userMessage');
      });

      _controller.clear();

      try {
        String history = _messages.join('\n');

        final response = await http.post(
          Uri.parse('http://192.168.1.85:5001/ask'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'question': userMessage, 'history': history}),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          setState(() {
            _messages.add('Bot: ${responseData['answer']}');
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

      _saveHistory();
    }
  }

  void _viewHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(messages: _messages),
      ),
    );
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
    _saveHistory();
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
                          backgroundImage: AssetImage('assets/images/perro.png'),
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
                          backgroundImage: AssetImage('assets/images/bot.jpeg'),
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
                    onPressed: _isConnected ? _sendMessage : null, // este es oa desactivar el boton cuando no hay wifi
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
