import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fahrplanauskunfts_app/models/location.dart';

class ApiLocationSearchService {
  static const String _baseURL =
      'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&coordOutputFormat=WGS84[DD:ddddd]&type_sf=any&name_sf=';

  Future<List<Location>> searchLocations(String searchQuery) async {
    final response = await http.get(Uri.parse(_baseURL + searchQuery));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      return _parseLocations(responseData);
    } else {
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }
  }

  List<Location> _parseLocations(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(responseData['locations']);
      final List<Location> results =
          data.map((result) => Location.fromJson(result)).toList();

      // Sort results by matchQuality in descending order
      results.sort((a, b) => b.matchQuality.compareTo(a.matchQuality));
      return results;
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
