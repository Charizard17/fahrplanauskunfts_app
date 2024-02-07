class Location {
  final String id;
  final String name;
  final String type;
  final String disassembledName;
  final int matchQuality;
  final List<double> coord;
  final bool isBest;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.disassembledName,
    required this.matchQuality,
    required this.coord,
    required this.isBest,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      disassembledName: json['disassembledName'] ?? '',
      matchQuality: json['matchQuality'] ?? 0,
      coord: [
        (json['coord'] as List<dynamic>)[1] as double,
        (json['coord'] as List<dynamic>)[0] as double,
      ],
      isBest: json['isBest'] ?? false,
    );
  }
}
