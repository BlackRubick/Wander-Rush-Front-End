import 'package:flutter/material.dart';

class AddPersonView extends StatelessWidget {
  const AddPersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFDAD3CC),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10.0),
                suffixIcon: Icon(Icons.search, color: Colors.black),
                hintText: '', 
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, 
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'), 
                radius: 30, 
              ),
              title: Text('Seol'),
              subtitle: Text('Hola'), 
              trailing: ElevatedButton(
                onPressed: () {
                  // Acción de seguir
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text('Seguir', style: TextStyle(color: Colors.white)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/chatFriend');
              },
            ),
          );
        },
      ),
    );
  }
}
