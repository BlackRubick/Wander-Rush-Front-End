import 'package:flutter/material.dart';
import 'package:wanderrush/Screens/UserView.dart';
import 'package:wanderrush/Screens/PerfilLugar.dart';
import 'package:wanderrush/Screens/HomePromotor.dart';

class PostScreenPromotor extends StatefulWidget {
  const PostScreenPromotor({super.key});

  @override
  _PostScreenPromotorState createState() => _PostScreenPromotorState();
}

class _PostScreenPromotorState extends State<PostScreenPromotor> {
  Color colorn = Color(0xFFF6F7F2);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [ Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,), // Margen horizontal
          child: TextButton(
            onPressed: () {
              // Acción del botón
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFD2EDFB),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Publicar', style: TextStyle(
              fontFamily: 'Poppins-Regular',
            ),),
          ),
        ),],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 500, // Ajusta la altura máxima
                maxWidth: 500, // Ajusta el ancho máximo
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF6F7F2),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Parte superior (similar al AppBar)
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/lugar1.png'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Museo del Café de Chiapas',
                            style: const TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Poppins-Regular',),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 16),
                    // Entrada de texto con descripción
                    Container(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Agregue una descripción...',hintStyle: TextStyle(fontFamily: 'Poppins-Regular',),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Imagen principal
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/sample_post_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Botón para agregar más imágenes
                    Center(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Acción para agregar más imágenes
                            },
                            icon: const Icon(Icons.add_photo_alternate, size: 40),
                            color: Colors.black,
                          ),
                          const Text(
                            'Agregar más',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
            icon: Icon(Icons.add_box, color: Colors.black, size: 30),
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
}