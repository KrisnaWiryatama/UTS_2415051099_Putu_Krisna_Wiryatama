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
}