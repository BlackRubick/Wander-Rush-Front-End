  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:speech_to_text/speech_to_text.dart' as stt;
  import 'package:flutter_tts/flutter_tts.dart';
  import 'package:flutter/services.dart';
  import 'package:wanderrush/screens/historyscreen.dart';

  class ChatbotScreen extends StatefulWidget {
    const ChatbotScreen({super.key});

    @override
    _ChatbotScreenState createState() => _ChatbotScreenState();
  }

  class _ChatbotScreenState extends State<ChatbotScreen> {
    List<String> _messages = [];
    final TextEditingController _controller = TextEditingController();
    late stt.SpeechToText _speech;
    bool _isListening = false;
    String _speechText = '';
    late FlutterTts _flutterTts;
    late List<String> _bannedWords = [];

    @override
    void initState() {
      super.initState();
      _speech = stt.SpeechToText();
      _flutterTts = FlutterTts();
      _loadHistory();
      _loadBannedWords();
    }

    // aqui metemos el json con als palabrotas
    Future<void> _loadBannedWords() async {
      final String response =
          await rootBundle.loadString('assets/images/banned_words.json');
      final data = jsonDecode(response);
      setState(() {
        _bannedWords = List<String>.from(data['bannedWords']);
      });
    }

    Future<void> _loadHistory() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _messages = prefs.getStringList('chat_history') ?? [];
      });
    }

    Future<void> _saveHistory() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('chat_history', _messages);
    }

    // esta es la funcion pa censurar los mensajes 
    String _censorBadWords(String message) {
      for (String word in _bannedWords) {
        //aqui valida si son mayusculas o ne
        if (message.toLowerCase().contains(word)) {
          message = message.replaceAll(RegExp(word, caseSensitive: false), '****');
        }
      }
      return message;
    }

    // manda mnensje al chatbot y obtenemos la respuesta
    Future<void> _sendMessage() async {
      if (_controller.text.isNotEmpty) {
        String userMessage = _controller.text;
        String censoredMessage = _censorBadWords(userMessage);

        // si tiene palabrotas lo censura 
        if (censoredMessage != userMessage) {
          setState(() {
            _messages.add('Usuario: (mensaje censurado)');
          });
        } else {
          setState(() {
            _messages.add('Usuario: $userMessage');
          });

          _controller.clear();

          try {
            String history = _messages.join('\n');

            final response = await http.post(
              Uri.parse('http://10.14.0.83:5001/ask'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'question': userMessage, 'history': history}),
            );

            if (response.statusCode == 200) {
              final responseData = jsonDecode(response.body);
              String botMessage = responseData['answer'];
              String censoredBotMessage = _censorBadWords(botMessage);

              setState(() {
                _messages.add('Bot: $censoredBotMessage');
              });

              await _flutterTts.speak(censoredBotMessage);
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
    }

    // Mostrar historial de chat
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

    Future<void> _startListening() async {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => setState(() => _isListening = val == 'listening'),
          onError: (val) => setState(() => _isListening = false),
        );
        if (available) {
          _speech.listen(
            onResult: (val) => setState(() {
              _speechText = val.recognizedWords;
              _controller.text = _speechText;
            }),
          );
        }
      } else {
        _speech.stop();
        setState(() {
          _isListening = false;
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 231, 210, 175),
          title: const Text(
            'TOKKI CHAT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          elevation: 8,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Align(
                      alignment: message.startsWith('Usuario:')
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: message.startsWith('Usuario:') 
                              ? Colors.blue.shade400 
                              : Colors.green.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.black : Colors.black,
                    ),
                    onPressed: _startListening,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Escribe tu mensaje...',
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey.shade700,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
