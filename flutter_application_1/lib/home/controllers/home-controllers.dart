import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/home/models/story.dart';
import 'package:flutter_application_1/home/repository/home-repository.dart';

class HomeControllers {
  Future<List<StoryDTO>> getCharacters() async {

    // 👇 AQUÍ ESTÁ LA CLAVE
    final http.Response response = await homeRepository.getCharacters();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return buildStories(data);
    } else {
      throw Exception('Failed to load characters');
    }
  }

  List<StoryDTO> buildStories(Map<String, dynamic> data) {
    final List<StoryDTO> stories = [];
    final List results = data['results'];

    for (var item in results) {
      stories.add(
        StoryDTO(
          name: item['name'],
          species: item['species'],
          status: item['status'],
          image: item['image'],
        ),
      );
    }

    return stories;
  }
}

final homeControllers = HomeControllers();
