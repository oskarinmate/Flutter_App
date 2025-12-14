import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/models/story.dart';

class DetailScreen extends StatelessWidget {
  final StoryDTO story;

  const DetailScreen({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.name),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen grande
          Image.network(
            story.image,
            height: 300,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("Especie: ${story.species}"),
                const SizedBox(height: 4),
                Text("Estado: ${story.status}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
