import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:journey_planner_app/widgets/search_results_list.dart';
import 'package:journey_planner_app/providers/search_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _searchPerformed = false;

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Journey Planner App',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      _performSearch(searchProvider, _searchController.text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter search text',
                      suffixIcon: IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _performSearch(searchProvider, _searchController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            if (!_searchPerformed)
              Expanded(
                child: Image.asset(
                  'assets/images/itinerary.png',
                  height: 200.0,
                ),
              ),
            if (_searchPerformed)
              Expanded(
                child: SearchResultsList(
                  results: searchProvider.searchResults,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _performSearch(SearchProvider searchProvider, String searchText) {
    setState(() {
      _searchPerformed = true;
    });
    searchProvider.search(searchText);
  }
}
