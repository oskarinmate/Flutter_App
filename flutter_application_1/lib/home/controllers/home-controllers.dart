import 'dart:convert';
import 'package:flutter_application_1/home/models/story.dart';
import 'package:flutter_application_1/home/repository/home-repository.dart';

class HomeControllers {
  int _page = 1;
  bool hasMore = true;

  Future<List<StoryDTO>> getCharacters() async {
    final response = await homeRepository.getCharacters(page: _page);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      if (results.isEmpty) {
        hasMore = false;
        return [];
      }

      _page++;

      return results.map((item) {
        return StoryDTO(
          name: item['name'],
          image: item['image'],
          species: item['species'],
          status: item['status'],
        );
      }).toList();
    } else {
      throw Exception('Error al cargar personajes');
    }
  }
}
