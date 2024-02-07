import 'package:dio/dio.dart';
import 'package:fahrplanauskunfts_app/models/search_result.dart';

class SearchService {
  final Dio _dio = Dio();

  Future<List<SearchResult>> searchResult(String searchText) async {
    try {
      final response = await _dio.get(
        'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&type_sf=%20any&name_sf=$searchText',
      );

      // Check if the request was successful (status code 200).
      if (response.statusCode == 200) {
        // Process the response and extract relevant information.
        List<SearchResult> results = [];

        // Ensure the response is a map
        if (response.data is Map<String, dynamic>) {
          // Access the 'locations' key to get the list of results
          List<Map<String, dynamic>> data =
              List<Map<String, dynamic>>.from(response.data['locations']);

          results =
              data.map((result) => SearchResult.fromJson(result)).toList();

          // Sort results by matchQuality in descending order
          results.sort((a, b) => b.matchQuality.compareTo(a.matchQuality));
        } else {
          throw 'Unerwartetes Reaktionsformat';
        }

        return results;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error:
              'Daten konnten nicht geladen werden, Statuscode: ${response.statusCode}',
        );
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        throw 'Schlechte Reaktion';
      } else if (error.type == DioExceptionType.connectionTimeout) {
        throw 'Zeitüberschreitung der Verbindung. Überprüfen Sie Ihre Verbindung';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        throw 'Zeitüberschreitung beim Empfang. Verbindung zum Server nicht möglich';
      } else {
        throw 'Etwas ist schief gelaufen: $error';
      }
    } catch (error) {
      throw 'Ein unerwarteter Fehler ist aufgetreten: $error';
    }
  }
}
