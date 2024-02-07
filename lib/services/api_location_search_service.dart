import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fahrplanauskunfts_app/models/location.dart';

class ApiLocationSearchService {
  static const String _baseURL =
      'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&coordOutputFormat=WGS84[DD:ddddd]&type_sf=any&name_sf=';

  Future<List<Location>> searchLocations(
      String searchQuery, http.Client client) async {
    final response = await fetchLocations(searchQuery, client);

    if (response.statusCode == 200) {
      final responseData = parseResponse(response);
      return parseLocations(responseData);
    } else {
      throw Exception(
        'Fehler beim Laden der Daten, Statuscode: ${response.statusCode}',
      );
    }
  }

  Future<http.Response> fetchLocations(
      String searchQuery, http.Client client) async {
    final response = await client.get(Uri.parse(_baseURL + searchQuery));
    return response;
  }

  dynamic parseResponse(http.Response response) {
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    return responseData;
  }

  List<Location> parseLocations(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final locationsData = responseData['locations'];

      if (locationsData is List<dynamic>) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(locationsData);
        final List<Location> results =
            data.map((result) => Location.fromJson(result)).toList();

        results.sort((a, b) => b.matchQuality.compareTo(a.matchQuality));
        return results;
      } else {
        throw Exception(
            'Unerwartetes Reaktionsformat: locations data is not a List');
      }
    } else {
      throw Exception(
          'Unerwartetes Reaktionsformat: response data is not a Map');
    }
  }
}
