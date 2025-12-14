import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/controllers/home-controllers.dart';
import 'package:flutter_application_1/home/models/story.dart';
import 'package:flutter_application_1/home/screens/widgets/home-card.dart';
import 'package:flutter_application_1/home/screens/widgets/home-button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 🔹 Controller
  final HomeControllers controller = HomeControllers();

  // 🔹 Estado
  final List<StoryDTO> stories = [];
  List<StoryDTO> filteredStories = [];

  bool isLoading = false;

  // 🔹 Buscador
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMoreCharacters();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // 🔹 Cargar personajes
  Future<void> _loadMoreCharacters() async {
    if (isLoading || !controller.hasMore) return;

    setState(() => isLoading = true);

    try {
      final newStories = await controller.getCharacters();

      setState(() {
        stories.addAll(newStories);
        _applySearch(); // 🔥 respeta búsqueda activa
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  // 🔍 BUSCAR SOLO CON BOTÓN
  void _applySearch() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredStories = List.from(stories);
      } else {
        filteredStories = stories.where((story) {
          return story.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // ❌ Limpiar búsqueda
  void _clearSearch() {
    searchController.clear();
    setState(() => filteredStories = List.from(stories));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 182, 212),
        title: const Text("Rick and Morty App"),
        actions: const [
          HomeButton(icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Column(
        children: [
          // 🔍 BUSCADOR CON BOTÓN
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Buscar personaje...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _applySearch,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),

          // 📜 LISTA
          Expanded(
            child: ListView.builder(
              itemCount: filteredStories.length + 1,
              itemBuilder: (context, index) {
                if (index == filteredStories.length) {
                  if (!controller.hasMore) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text("No hay más personajes"),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _loadMoreCharacters,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Cargar más"),
                    ),
                  );
                }

                return HomeCard(story: filteredStories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
