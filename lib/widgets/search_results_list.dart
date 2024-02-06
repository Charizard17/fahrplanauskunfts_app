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
      children: [
        Text("${results.length} locations found"),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: SearchResultItem(result: result),
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
    return ListTile(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(result.name),
      subtitle: Text(result.disassembledName),
      trailing: Icon(
        color: Colors.orange,
        result.isBest ? Icons.star : null,
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}
