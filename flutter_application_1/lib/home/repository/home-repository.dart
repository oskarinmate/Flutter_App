import 'package:http/http.dart' as http;

class HomeRepository {
  final String api = "https://rickandmortyapi.com/api/";

  Future<http.Response> getCharacters() async {
    return await http.get(
      Uri.parse("${api}character"),
    );
  }
}

final homeRepository = HomeRepository();
