import 'package:http/http.dart' as http;

class HomeRepository {
  final String api = "https://rickandmortyapi.com/api/";

  Future<http.Response> getCharacters({int page = 1}) async {
    return await http.get(
      Uri.parse("${api}character?page=$page"),
    );
  }
}

// Instancia única
final HomeRepository homeRepository = HomeRepository();
