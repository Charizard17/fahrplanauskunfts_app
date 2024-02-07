import 'package:dio/dio.dart';
import 'package:journey_planner_app/models/search_result.dart';

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

          // Filter results based on matchQuality >= 900
          // results = results.where((result) => result.matchQuality >= 900).toList();
        } else {
          throw 'Unexpected response format';
        }

        return results;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load data, status code: ${response.statusCode}',
        );
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        throw 'Bad response';
      } else if (error.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout. Check your connection';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        throw 'Receive timeout. Unable to connect to the server';
      } else {
        throw 'Something went wrong: $error';
      }
    } catch (error) {
      throw 'Unexpected error occurred: $error';
    }
  }
}
