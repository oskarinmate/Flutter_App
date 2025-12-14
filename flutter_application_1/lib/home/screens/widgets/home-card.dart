import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/models/story.dart';
import 'package:flutter_application_1/home/screens/detail/detail-screen.dart';

class HomeCard extends StatelessWidget {
  final StoryDTO story;

  const HomeCard({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegación a la pantalla de detalle
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(story: story),
          ),
        );
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        color: const Color.fromARGB(255, 59, 64, 65),
        child: Row(
          children: [
            Image.network(
              story.image,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    story.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    story.species,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    story.status,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
