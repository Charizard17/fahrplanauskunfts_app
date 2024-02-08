import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fahrplanauskunfts_app/models/location.dart';

class ApiLocationSearchService {
  static const String _baseURL =
      'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&coordOutputFormat=WGS84[DD:ddddd]&type_sf=any&name_sf=';

  Future<List<Location>> searchLocations(
      String searchQuery, http.Client client) async {
    final response = await fetchData(searchQuery, client);

    if (response.statusCode != 200) {
      throw Exception(
        'Fehler beim Laden der Daten, Statuscode: ${response.statusCode}',
      );
    }
    final responseData = parseResponse(response);
    return parseLocations(responseData);
  }

  Future<http.Response> fetchData(
      String searchQuery, http.Client client) async {
    return await client.get(Uri.parse(_baseURL + searchQuery));
  }

  dynamic parseResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  List<Location> parseLocations(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      throw Exception(
          'Unerwartetes Reaktionsformat: Reaktionsdaten sind keine Zuordnung');
    }

    final locationsData = responseData['locations'];

    if (locationsData is! List<dynamic>) {
      throw Exception(
          'Unerwartetes Reaktionsformat: Ortsdaten sind keine Liste');
    }

    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(locationsData);
    final List<Location> results =
        data.map((result) => Location.fromJson(result)).toList();

    results.sort((a, b) => b.matchQuality.compareTo(a.matchQuality));
    return results;
  }
}
