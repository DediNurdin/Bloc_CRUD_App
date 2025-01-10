import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'utils.dart';

class ShimmerWidget {
  static gridShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Utils.isDarkMode(context)
            ? Colors.grey.shade600
            : Colors.grey.shade300,
        highlightColor: Utils.isDarkMode(context)
            ? Colors.grey.shade400
            : Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              childAspectRatio: 0.79,
            ),
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
            itemCount: 8,
          ),
        ));
  }

  static listShimmer(
    BuildContext context,
    bool isHorizon,
  ) {
    return Shimmer.fromColors(
        baseColor: Utils.isDarkMode(context)
            ? Colors.grey.shade600
            : Colors.grey.shade300,
        highlightColor: Utils.isDarkMode(context)
            ? Colors.grey.shade400
            : Colors.grey[100]!,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: isHorizon ? Axis.horizontal : Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: isHorizon
                  ? EdgeInsets.only(left: index == 0 ? 10 : 0)
                  : EdgeInsets.symmetric(horizontal: 10),
              width: isHorizon ? 130 : double.infinity,
              height: 130,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          itemCount: 5,
        ));
  }

  static chipShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Utils.isDarkMode(context)
            ? Colors.grey.shade600
            : Colors.grey.shade300,
        highlightColor: Utils.isDarkMode(context)
            ? Colors.grey.shade400
            : Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Chip(label: Text('       ')),
                  const SizedBox(
                    width: 8,
                  ),
                  Chip(label: Text('       ')),
                  const SizedBox(
                    width: 8,
                  ),
                  Chip(label: Text('       ')),
                ],
              )),
        ));
  }
}
