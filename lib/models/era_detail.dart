class EraDinoInfo {
  final String id;
  final String name;
  final String role; // Apex Predator, Megaherbivora, etc.
  final String diet;
  final String brief;

  const EraDinoInfo({
    required this.id,
    required this.name,
    required this.role,
    required this.diet,
    required this.brief,
  });
}

class EraDetailData {
  final String name;
  final String timeline;
  final String summary;
  final String climate;
  final String geography;
  final String flora;
  final String landmarkEvent;
  final List<EraDinoInfo> keyDinos;

  const EraDetailData({
    required this.name,
    required this.timeline,
    required this.summary,
    required this.climate,
    required this.geography,
    required this.flora,
    required this.landmarkEvent,
    required this.keyDinos,
  });
}