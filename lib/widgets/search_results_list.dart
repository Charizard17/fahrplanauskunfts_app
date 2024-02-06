import 'package:flutter/material.dart';
import 'package:journey_planner_app/models/search_result.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;

  const SearchResultsList({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(
        // TODO: add an image here
        child: Text('No search results'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("${results.length} locations found"),
        const SizedBox(height: 5.0),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];

              return SearchResultItem(
                result: result,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchResultItem extends StatelessWidget {
  final SearchResult result;

  const SearchResultItem({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result.name),
                Text("Ort: ${result.disassembledName}"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  color: Colors.orange,
                  result.isBest ? Icons.star : null,
                ),
                Text("Typ: ${result.type}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
