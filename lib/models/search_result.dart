class SearchResult {
  final String id;
  final String name;
  final String type;
  final String disassembledName;
  final int matchQuality;
  final List<double> coord;
  final bool isBest;

  SearchResult({
    required this.id,
    required this.name,
    required this.type,
    required this.disassembledName,
    required this.matchQuality,
    required this.coord,
    required this.isBest,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      disassembledName: json['disassembledName'] ?? '',
      matchQuality: json['matchQuality'] ?? 0,
      coord: (json['coord'] as List<dynamic>)
          .map<double>((e) => e as double)
          .toList(),
      isBest: json['isBest'] ?? false,
    );
  }
}
