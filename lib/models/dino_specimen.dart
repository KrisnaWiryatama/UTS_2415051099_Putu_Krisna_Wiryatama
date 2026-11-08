class DinoSpecimen {
  final String id;
  final String name;
  final String diet; // Carnivora, Herbivora, Omnivora
  final String era;
  final String length;
  final String weight;
  final String description;
  final String discoveredIn;
  final int likeCount;

  const DinoSpecimen({
    required this.id,
    required this.name,
    required this.diet,
    required this.era,
    required this.length,
    required this.weight,
    required this.description,
    required this.discoveredIn,
    this.likeCount = 0,
  });

  DinoSpecimen copyWith({
    String? id,
    String? name,
    String? diet,
    String? era,
    String? length,
    String? weight,
    String? description,
    String? discoveredIn,
    int? likeCount,
  }) {
    return DinoSpecimen(
      id: id ?? this.id,
      name: name ?? this.name,
      diet: diet ?? this.diet,
      era: era ?? this.era,
      length: length ?? this.length,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      discoveredIn: discoveredIn ?? this.discoveredIn,
      likeCount: likeCount ?? this.likeCount,
    );
  }

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
      likeCount: json['like_count'] ?? json['likeCount'] ?? 0,
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
      'like_count': likeCount,
    };
  }
}