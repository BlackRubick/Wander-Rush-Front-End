import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPersonView extends StatefulWidget {
  const AddPersonView({super.key});

  @override
  _AddPersonViewState createState() => _AddPersonViewState();
}

class _AddPersonViewState extends State<AddPersonView> {
  late Future<List<User>> _users;
  List<User> filteredUsers = []; // Lista para manejar los usuarios filtrados por búsqueda
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
    searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/users')); // Cambia la URL según tu API

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  void _filterUsers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = filteredUsers
          .where((user) =>
              user.username.toLowerCase().contains(query) ||
              user.email.toLowerCase().contains(query))
          .toList();
    });
  }

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
              controller: searchController, // Controlador del campo de búsqueda
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10.0),
                suffixIcon: Icon(Icons.search, color: Colors.black),
                hintText: 'Buscar usuarios',
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay usuarios disponibles'));
          }

          // Inicializar usuarios filtrados si está vacío
          if (filteredUsers.isEmpty && searchController.text.isEmpty) {
            filteredUsers = snapshot.data!;
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 30,
                  ),
                  title: Text(user.username),
                  subtitle: Text(user.email),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Acción de seguir
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('Seguir', style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/chatFriend');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class User {
  final int id;
  final String email;
  final String username;

  User({required this.id, required this.email, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }
}
