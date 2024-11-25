import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<String> messages;

  const HistoryScreen({super.key, this.messages = const []}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Conversaciones'),
        backgroundColor: Colors.grey.shade200,
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  messages[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
