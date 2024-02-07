import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/search_result.dart';
import 'package:fahrplanauskunfts_app/widgets/search_result_item.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;

  const SearchResultsList({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          results.length > 1
              ? "${results.length} Orte gefunden"
              : "${results.length} Ort gefunden",
        ),
        const SizedBox(height: 5.0),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return SearchResultItem(result: result);
            },
          ),
        ),
      ],
    );
  }
}
