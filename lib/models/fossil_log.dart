class FossilLog {
  final String? id;
  final String title;
  final String specimenType;
  final String location;
  final String notes;
  final DateTime createdAt;

  FossilLog({
    this.id,
    required this.title,
    required this.specimenType,
    required this.location,
    required this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory FossilLog.fromJson(Map<String, dynamic> json) {
    return FossilLog(
      id: json['id']?.toString(),
      title: json['title'] ?? '',
      specimenType: json['specimen_type'] ?? json['specimenType'] ?? 'Fosil',
      location: json['location'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'specimen_type': specimenType,
      'location': location,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}