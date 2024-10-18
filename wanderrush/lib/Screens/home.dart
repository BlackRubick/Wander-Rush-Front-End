import 'package:flutter/material.dart';
import 'package:wanderrush/screens/chatbot.dart'; 

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Qué categorías te gustaría buscar hoy?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildCategoryButton('Arte'),
                  _buildCategoryButton('Cine'),
                  _buildCategoryButton('Música'),
                  _buildCategoryButton('Parques'),
                  _buildCategoryButton('Deporte'),
                  _buildCategoryButton('Áire libre'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chatbot'); 
        },
        backgroundColor: Color(0xFFE88A73),
        child: Icon(Icons.chat_bubble, color: Colors.black),
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
            icon: Icon(Icons.add_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
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
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        iconSize: 30,
        onTap: (index) {
          // Manejar la navegación de la barra inferior aquí
        },
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Acción para cada categoría
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF9E5B8),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
