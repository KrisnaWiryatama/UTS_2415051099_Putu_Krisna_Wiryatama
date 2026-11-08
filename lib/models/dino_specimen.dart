class DinoSpecimen {
  final String id;
  final String name;
  final String diet; // Carnivora, Herbivora, Omnivora
  final String era;
  final String length;
  final String weight;
  final String description;
  final String discoveredIn;

  const DinoSpecimen({
    required this.id,
    required this.name,
    required this.diet,
    required this.era,
    required this.length,
    required this.weight,
    required this.description,
    required this.discoveredIn,
  });

  factory DinoSpecimen.fromJson(Map<String, dynamic> json) {
    return DinoSpecimen(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      diet: json['diet'] ?? 'Carnivora',
      era: json['era'] ?? '',
      length: json['length'] ?? '',
      weight: json['weight'] ?? '',
      description: json['description'] ?? '',
      discoveredIn: json['discoveredIn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'diet': diet,
      'era': era,
      'length': length,
      'weight': weight,
      'description': description,
      'discoveredIn': discoveredIn,
    };
  }
}