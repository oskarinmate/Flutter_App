class StoryDTO {
  final String name;
  final String image;
  final String species;
  final String status;

  StoryDTO({
    required this.name,
    required this.image,
    required this.species,
    required this.status,
  });

  factory StoryDTO.fromJson(Map<String, dynamic> json) {
    return StoryDTO(
      name: json['name'],
      image: json['image'],
      species: json['species'],
      status: json['status'],
    );
  }
}
