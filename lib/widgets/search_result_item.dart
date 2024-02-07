import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/search_result.dart';

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
