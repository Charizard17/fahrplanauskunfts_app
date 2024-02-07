import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/location.dart';
import 'package:fahrplanauskunfts_app/widgets/location_list_item.dart';

class LocationResultsList extends StatelessWidget {
  final List<Location> results;
  final ValueChanged<Location> onItemSelected;

  const LocationResultsList({
    Key? key,
    required this.results,
    required this.onItemSelected,
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return LocationListItem(
                result: result,
                onTap: () {
                  onItemSelected(result);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
