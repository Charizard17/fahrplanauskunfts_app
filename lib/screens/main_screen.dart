import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable_info_app/providers/search_provider.dart';
import 'package:timetable_info_app/models/search_result.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable Information App'),
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
              child: _buildSearchResults(searchProvider.searchResults),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<SearchResult> results) {
    if (results.isEmpty) {
      return const Center(
        child: Text('No search results'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];

        return ListTile(
          title: Text(result.name),
          subtitle: Text(result.disassembledName),
          trailing: Text(result.matchQuality.toString()),
          // Customize the way you want to display additional information.
          // For example: subtitle: Text(result.placeName ?? ''),
        );
      },
    );
  }
}
