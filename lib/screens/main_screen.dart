import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:journey_planner_app/widgets/search_results_list.dart';
import 'package:journey_planner_app/providers/search_provider.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey Planner App'),
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
                      searchProvider.search(_searchController.text);
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
                    searchProvider.search(_searchController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
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
}
