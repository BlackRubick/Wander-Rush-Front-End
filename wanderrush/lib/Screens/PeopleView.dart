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
                hintText: '', // Texto de sugerencia
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // Cambia este número según la cantidad de elementos que quieras mostrar
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'), // Imagen del avatar
                radius: 30, // Tamaño del avatar
              ),
              title: Text('Seol'), // Nombre de la persona
              subtitle: Text('Hola'), // Mensaje o descripción
              onTap: () {
                // Navegar a la vista de ChatFriend al pulsar la tarjeta
                Navigator.pushNamed(context, '/chatFriend');
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFDAD3CC),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box), // Cambiado a ícono de "más"
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), // Ícono de "people"
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'), 
              radius: 20,
            ),
            label: '',
          ),
        ],
        currentIndex: 3, // Cambia este índice según la pestaña activa
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        onTap: (index) {
          // Manejar la navegación de la barra inferior
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Navegar a la vista de inicio
              break;
            case 1:
              Navigator.pushNamed(context, '/search'); // Navegar a la vista de búsqueda
              break;
            case 2:
              // Aquí puedes manejar la acción para crear un nuevo mensaje
              break;
            case 3:
              // Ya estás en la vista de PeopleView
              break;
          }
        },
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Acción para abrir el chat o enviar un mensaje
            },
            backgroundColor: Color(0xFFE88A73),
            child: Icon(Icons.chat_bubble, color: Colors.black), // Ícono de burbuja de chat
          ),
          SizedBox(height: 16), // Espacio entre los botones
          FloatingActionButton(
            onPressed: () {
              // Acción para enviar un nuevo mensaje
            },
            backgroundColor: Color(0xFFE88A73),
            child: Icon(Icons.message, color: Colors.black), // Ícono de mensaje nuevo
          ),
        ],
      ),
    );
  }
}
