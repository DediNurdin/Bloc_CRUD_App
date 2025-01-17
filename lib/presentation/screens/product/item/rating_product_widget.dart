import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingProductWidget extends StatelessWidget {
  const RatingProductWidget({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Icon(
            size: 15,
            index < value ? CupertinoIcons.star_fill : CupertinoIcons.star,
            color: Colors.amber,
          ),
        );
      }),
    );
  }
}
