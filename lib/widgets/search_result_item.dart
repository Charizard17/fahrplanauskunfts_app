import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/search_result.dart';

class SearchResultItem extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const SearchResultItem({
    Key? key,
    required this.result,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                Expanded(
                  child: Text(
                    result.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                if (result.isBest)
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.star,
                      color: Colors.orange,
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
      ),
    );
  }
}
