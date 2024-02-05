import 'package:flutter/material.dart';
import 'package:timetable_info_app/models/search_result.dart';
import 'package:timetable_info_app/services/search_service.dart';

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  List<SearchResult> _searchResults = [];

  List<SearchResult> get searchResults => _searchResults;

  Future<void> search(String searchText) async {
    _searchResults = await _searchService.searchResult(searchText);
    notifyListeners();
  }
}
