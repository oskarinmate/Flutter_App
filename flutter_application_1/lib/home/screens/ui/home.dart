import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/controllers/home-controllers.dart';
import 'package:flutter_application_1/home/models/story.dart';
import 'package:flutter_application_1/home/screens/widgets/home-button.dart';
import 'package:flutter_application_1/home/screens/widgets/home-card.dart';

class HomeScreen extends StatelessWidget {

  final HomeControllers homeControllers = HomeControllers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: const Text("Rick and Morty App"),
        actions: const [
          HomeButton(icon: Icon(Icons.notifications)),
          HomeButton(icon: Icon(Icons.exit_to_app)),
        ],
      ),

      // 🔥 AQUÍ SÍ USAMOS EL FUTUREBUILDER
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<StoryDTO>>(
          future: homeControllers.getCharacters(),
          builder: (context, snapshot) {

            // Cargando
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return const Center(child: Text("Error al cargar personajes"));
            }

            // Sin datos
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay personajes"));
            }

            // ✅ Datos correctos
            return buildCharacters(snapshot.data!);
          },
        ),
      ),
    );
  }
}
Widget buildCharacters(List<StoryDTO> stories) {
  return ListView.builder(
    itemCount: stories.length,
    itemBuilder: (context, index) {
      return HomeCard(story: stories[index]);
    },
  );
}
