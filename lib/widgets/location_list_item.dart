import 'package:flutter/material.dart';
import 'package:fahrplanauskunfts_app/models/location.dart';

class LocationListItem extends StatelessWidget {
  final Location result;
  final VoidCallback onTap;

  const LocationListItem({
    Key? key,
    required this.result,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(
          bottom: 10.0,
          right: 5,
          left: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    result.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (result.isBest)
                  const Icon(
                    Icons.star,
                    color: Colors.deepOrange,
                  ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Ort: ${result.disassembledName}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Typ: ${result.type}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
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
