import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/home/models/story.dart';
import 'package:flutter_application_1/home/repository/home-repository.dart';

class HomeControllers {
  // 🔹 Página actual
  int _page = 1;

  // 🔹 Indica si hay más páginas
  bool hasMore = true;

  // 🔹 Obtiene personajes (una página por llamada)
  Future<List<StoryDTO>> getCharacters() async {
    final http.Response response =
        await homeRepository.getCharacters(page: _page);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      // 🔹 Verifica si existe una página siguiente
      hasMore = data['info']['next'] != null;

      // 🔹 Avanza página
      _page++;

      return _buildStories(data);
    } else {
      throw Exception('Failed to load characters');
    }
  }

  // 🔹 Convierte JSON a lista de StoryDTO
  List<StoryDTO> _buildStories(Map<String, dynamic> data) {
    final List results = data['results'];

    return results.map<StoryDTO>((item) {
      return StoryDTO(
        name: item['name'],
        image: item['image'],
        species: item['species'],
        status: item['status'],
      );
    }).toList();
  }
}

// 🔹 Instancia global (simple)
final HomeControllers homeControllers = HomeControllers();
