import 'package:flutter/material.dart';
import 'package:wanderrush/Screens/UserView.dart';
import 'package:wanderrush/Screens/HomePromotor.dart';
import 'package:wanderrush/Screens/PostScreenPromotor.dart';
import 'package:wanderrush/Screens/EditLugar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Perfillugar extends StatefulWidget {
  @override
  _PerfillugarState createState() => _PerfillugarState();
}

class _PerfillugarState extends State<Perfillugar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color colorn = Color(0xFFF6F7F2);
  double _rating = 0.0;


  @override
  void initState() {
    super.initState();
    // Inicializando el TabController con 2 pestañas
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),

            TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black12,
              labelStyle: TextStyle(
                fontFamily: 'Poppins', // Cambia por la fuente que desees
                fontSize: 16,
                fontWeight: FontWeight.w600, // Peso de la fuente
              ),
              tabs: [
                Tab(text: 'Información'),
                Tab(text: 'Reseñas'),
              ],
            ),


            // Contenido de las pestañas
            Container(
              height: 1000, // Ajusta según sea necesario
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildInfoSection(),  // Contenido para Información
                  _buildReviewSection(),  // Contenido para Reseñas
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: colorn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black54, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePromotor(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                  Icons.add_box_outlined, color: Colors.black54, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostScreenPromotor(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                  Icons.people_alt_outlined, color: Colors.black54, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserView(),
                  ),
                );
              },
            ),
            IconButton(
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/lugar1.png'),
                radius: 18,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Perfillugar(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Alinea al inicio vertical
            children: [
              // Imagen en círculo
              CircleAvatar(
                radius: 50, // Tamaño del círculo
                backgroundImage: AssetImage(
                    'assets/images/lugar1.png'), // Ruta de la imagen
              ),
              SizedBox(width: 150), // Espacio entre el círculo y los íconos
              // Íconos
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon:  Icon(Icons.create_sharp, size: 30, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditLugar(),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 30,), // Espacio entre íconos
                      IconButton(
                        icon:
                        Icon(Icons.settings, size: 30, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16), // Espacio entre el Row y el texto
          // Nombre
          Text(
            'Museo del Café de Chiapas',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins-Regular', // Asegúrate de usar comillas y el nombre correcto
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Descripción
          Text(
            'Consejo Estatal para las Culturas y las Artes de Chiapas.',
            style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Calzada al sumidero, Las Granjas, Tuxtla Gutiérrez, Chis.',
                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Abre a las 10 a.m. del Lun',
                style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.green),
              SizedBox(width: 8),
              Text(
                '961 611 1478',
                style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
              ),
            ],
          ),

          SizedBox(height: 16), // Espacio entre la descripción y el mapa

          // Mapa
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage('assets/images/mapa.png'), // Sustituye con un mapa real si es necesario
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 16), // Espacio entre el mapa y los botones

          // Botones debajo del mapa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBE9E7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Comprar entradas', style: TextStyle(fontFamily: 'Poppins', color: Colors.black),)
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFCDD2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('¿Cómo llegar?', style: TextStyle(fontFamily: 'Poppins', color: Colors.black),),
              ),
            ],
          ),

      Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/lugar1.png'),
              ),
              title: Text('Museo del Café de Chiapas', style: TextStyle(fontFamily: 'Poppins', fontSize: 14),),
              subtitle: Text('Olor chiapaneco', style: TextStyle(fontFamily: 'Poppins', fontSize: 11)),
              trailing: Icon(Icons.more_vert),
            ),
            Image.asset('assets/images/lugar1.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 16),
                  Icon(Icons.comment_outlined),
                  SizedBox(width: 16),
                  Icon(Icons.send),
                ],
              ),
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }


  Widget _buildReviewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(

        children: [
      Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            title: Text('Jay B'),
            subtitle: Text('Un agradable lugar'),
            trailing: Icon(Icons.more_vert),
          ),
          Image.asset('assets/images/lugar1.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined),
                SizedBox(width: 16),
                Icon(Icons.send),
              ],
            ),
          ),
        ],
      ),
    ),Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
          // Encabezado de la sección
          Container(
            color: Color(0xFFF6F7F2),
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              'Comentarios',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Lista de reseñas
          Container(
            color: Color(0xFFF6F7F2),
            height: 420, // Puedes ajustar el tamaño según lo que necesites
            child: ListView(
              children: [
                _buildComentario(
                  nombre: 'Jay B',
                  comentario: 'El aroma de Chiapas @Museo del Café de Chiapas',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
                _buildComentario(
                  nombre: 'Pato',
                  comentario: 'Me gustó mucho el lugar',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
                _buildComentario(
                  nombre: 'César',
                  comentario: 'Me encantó la historia detrás del museo.',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),_buildComentario(
                  nombre: 'César',
                  comentario: 'Me encantó la historia detrás del museo.',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),_buildComentario(
                  nombre: 'César',
                  comentario: 'Me encantó la historia detrás del museo.',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
                _buildComentario(
                  nombre: 'César',
                  comentario: 'Me encantó la historia detrás del museo.',
                  imagenUrl: 'https://via.placeholder.com/50',
                ),
              ],
            ),
          ),
          //SizedBox(height: 100),
          // Barra de comentario para agregar nuevos comentarios
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe un comentario...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // Acción para enviar el comentario
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Comentario enviado')),
                    );
                  },
                  icon: Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComentario({required String nombre, required String comentario, required String imagenUrl}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imagenUrl),
      ),
      title: Text(nombre, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(comentario),
    );
  }
}


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Eliminar cuenta'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Términos y condiciones'),
            onTap: () {
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}