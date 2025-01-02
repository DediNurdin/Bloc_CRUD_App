import 'package:flutter/material.dart';

class RatingProductWidget extends StatelessWidget {
  const RatingProductWidget({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          size: 18,
          index < value ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        );
      }),
    );
  }
}
