class SearchResult {
  final String id;
  final String name;
  final String type;
  final String disassembledName;
  final int matchQuality;

  SearchResult({
    required this.id,
    required this.name,
    required this.type,
    required this.disassembledName,
    required this.matchQuality,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      disassembledName: json['disassembledName'] ?? '',
      matchQuality: json['matchQuality'] ?? 0,
    );
  }
}
