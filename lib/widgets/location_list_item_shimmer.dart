import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LocationListItemShimmer extends StatelessWidget {
  const LocationListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
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
                Container(
                  width: 24.0,
                  height: 24.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Container(
                    height: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 16.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 16.0,
                    width: 100.0,
                    color: Colors.white,
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
