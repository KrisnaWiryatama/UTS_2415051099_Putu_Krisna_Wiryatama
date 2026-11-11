class EraDinoInfo {
  final String name;
  final String role;
  final String length;
  final String diet;
  final String brief;

  const EraDinoInfo({
    required this.name,
    required this.role,
    this.length = '-',
    this.diet = 'Carnivora',
    this.brief = '',
  });
}

class EraDetailData {
  final String name;
  final String timeline;
  final String summary;
  final String geography;
  final String flora;
  final String climate;
  final String fauna;
  final String landmarkEvent;
  final List<EraDinoInfo> keyDinos;

  const EraDetailData({
    required this.name,
    required this.timeline,
    required this.summary,
    required this.geography,
    required this.flora,
    this.climate = '',
    this.fauna = '',
    this.landmarkEvent = '',
    this.keyDinos = const [],
  });
}