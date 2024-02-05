import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timetable_info_app/models/search_result.dart';

class SearchService {
  final Dio _dio = Dio();

  Future<List<SearchResult>> searchResult(String searchText) async {
    try {
      final response = await _dio.get(
        'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&coordOutputFormat=WGS84[DD:ddddd]&type_sf=any&name_sf=$searchText',
      );

      // Check if the request was successful (status code 200).
      if (response.statusCode == 200) {
        // Process the response and extract relevant information.
        List<SearchResult> results = [];

        // Ensure the response is a list
        if (response.data is List) {
          List<Map<String, dynamic>> data =
              List<Map<String, dynamic>>.from(response.data);
          results =
              data.map((result) => SearchResult.fromJson(result)).toList();

          // Filter results based on matchQuality >= 900
          results =
              results.where((result) => result.matchQuality >= 900).toList();
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
