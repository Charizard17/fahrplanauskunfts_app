import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LocationListItemShimmer extends StatelessWidget {
  const LocationListItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 5.0),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Container(
                  width: 180,
                  height: 20,
                  color: Colors.white,
                ),
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
