import 'package:flutter/material.dart';

class PeopleView extends StatelessWidget {
  const PeopleView({super.key});

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
              onTap: () {
                Navigator.pushNamed(context, '/chatFriend');
              },
              trailing: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'Eliminar chat') {
                    print('Eliminar chat');
                  } else if (value == 'Ver perfil') {
                    Navigator.pushNamed(context, '/profile');
                  } else if (value == 'Dejar de seguir') {
                    print('Dejar de seguir');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Eliminar chat',
                      child: Text('Eliminar chat'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Ver perfil',
                      child: Text('Ver perfil'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Dejar de seguir',
                      child: Text('Dejar de seguir'),
                    ),
                  ];
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addPerson');
            },
            backgroundColor: Color(0xFFE88A73),
            child: Icon(Icons.person_add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
