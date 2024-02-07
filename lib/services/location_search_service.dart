import 'package:dio/dio.dart';
import 'package:fahrplanauskunfts_app/models/location.dart';

class LocationSearchService {
  final Dio _dio = Dio();

  Future<List<Location>> searchLocations(String searchQuery) async {
    try {
      final response = await _dio.get(
        'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&coordOutputFormat=WGS84[DD:ddddd]&type_sf=any&name_sf=$searchQuery',
      );

      if (response.statusCode == 200) {
        final List<Location> results = _parseLocations(response.data);
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
      _handleDioError(error);
    } catch (error) {
      throw 'Ein unerwarteter Fehler ist aufgetreten: $error';
    }
    throw 'Die Funktion hat möglicherweise ohne Rückgabewert abgeschlossen.';
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
      throw 'Unerwartetes Reaktionsformat';
    }
  }

  void _handleDioError(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      throw 'Daten konnten nicht geladen werden, Statuscode: ${error.response?.statusCode}';
    } else if (error.type == DioExceptionType.connectionTimeout) {
      throw 'Zeitüberschreitung der Verbindung. Überprüfen Sie Ihre Verbindung';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      throw 'Zeitüberschreitung beim Empfang. Verbindung zum Server nicht möglich';
    } else {
      throw 'Etwas ist schief gelaufen: $error';
    }
  }
}
