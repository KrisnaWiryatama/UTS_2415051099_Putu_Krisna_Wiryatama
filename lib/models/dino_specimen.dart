class DinoSpecimen {
  final String id;
  final String name;
  final String era;
  final String diet;
  final String discoveredIn;
  final String length;
  final String weight;
  final String description;
  final int likeCount;
  final String? imageUrl;

  const DinoSpecimen({
    required this.id,
    required this.name,
    required this.era,
    required this.diet,
    required this.discoveredIn,
    required this.length,
    required this.weight,
    required this.description,
    this.likeCount = 0,
    this.imageUrl,
  });

  factory DinoSpecimen.fromJson(Map<String, dynamic> json) {
    return DinoSpecimen(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      era: json['era']?.toString() ?? 'Mesozoic Era',
      diet: json['diet']?.toString() ?? 'Carnivora',
      discoveredIn: json['discovered_in']?.toString() ??
          json['discoveredIn']?.toString() ??
          'Asia',
      length: json['length']?.toString() ?? '-',
      weight: json['weight']?.toString() ?? '-',
      description: json['description']?.toString() ?? '',
      likeCount: json['like_count'] ?? json['likeCount'] ?? 0,
      imageUrl: json['image_url'] ?? json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'era': era,
      'diet': diet,
      'discovered_in': discoveredIn,
      'length': length,
      'weight': weight,
      'description': description,
      'like_count': likeCount,
      if (imageUrl != null) 'image_url': imageUrl,
    };
  }

  DinoSpecimen copyWith({
    String? id,
    String? name,
    String? era,
    String? diet,
    String? discoveredIn,
    String? length,
    String? weight,
    String? description,
    int? likeCount,
    String? imageUrl,
  }) {
    return DinoSpecimen(
      id: id ?? this.id,
      name: name ?? this.name,
      era: era ?? this.era,
      diet: diet ?? this.diet,
      discoveredIn: discoveredIn ?? this.discoveredIn,
      length: length ?? this.length,
      weight: weight ?? this.weight,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}