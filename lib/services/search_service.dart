import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner_app/models/search_result.dart';

class SearchService {
  final Dio _dio = Dio();

  Future<List<SearchResult>> searchResult(String searchText) async {
    try {
      final response = await _dio.get(
        'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&type_sf=%20any&name_sf=$searchText',
      );

      // Log the status code and headers for debugging
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Headers: ${response.headers}');

      // Check if the request was successful (status code 200).
      if (response.statusCode == 200) {
        // Process the response and extract relevant information.
        List<SearchResult> results = [];

        // Print the raw response data for debugging

        // Ensure the response is a map
        if (response.data is Map<String, dynamic>) {
          // Access the 'locations' key to get the list of results
          List<Map<String, dynamic>> data =
              List<Map<String, dynamic>>.from(response.data['locations']);

          debugPrint('Number of locations: ${data.length}');
          debugPrint('Locations: ${data.toString()}');

          results =
              data.map((result) => SearchResult.fromJson(result)).toList();

          // Sort results by matchQuality in descending order
          results.sort((a, b) => b.matchQuality.compareTo(a.matchQuality));

          // Filter results based on matchQuality >= 900
          // results = results.where((result) => result.matchQuality >= 900).toList();
        } else {
          debugPrint('Unexpected response format');
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
    } on DioError catch (error) {
      if (error.type == DioErrorType.badResponse) {
        debugPrint('Bad response');
      } else if (error.type == DioErrorType.connectionTimeout) {
        debugPrint('Connection timeout. Check your connection');
      } else if (error.type == DioErrorType.receiveTimeout) {
        debugPrint('Receive timeout. Unable to connect to the server');
      } else {
        debugPrint('Something went wrong: $error');
      }

      // Re-throw the exception to propagate it further
      throw error;
    } catch (error) {
      debugPrint('Unexpected error: $error');
      // Re-throw the exception to propagate it further
      throw error;
    }
  }
}
