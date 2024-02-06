import 'package:flutter/material.dart';
import 'package:journey_planner_app/models/search_result.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;

  const SearchResultsList({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const Center(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (result.isBest)
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                ),
              Expanded(
                child: Text(
                  result.name,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text("Ort: ${result.disassembledName}"),
              ),
              Container(
                width: 100,
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Typ: ${result.type}"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
