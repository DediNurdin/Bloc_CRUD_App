import 'package:flutter/material.dart';

import 'rating_product_widget.dart';

class ReviewWidget extends StatelessWidget {
  final List<Review> reviews = [
    Review(
      title: 'True Classic, Impressive QC',
      rating: 5,
      id: 'b873cdeb-8429-4db5-8393-0dd788d214d...',
      content:
          'Just as I expected. Reliable comfort, and still cool. I was very impressed by the quality, all seams and overlays are stitched nicely and...',
    ),
    Review(
      title: 'disappointing',
      rating: 2,
      id: '97558b52-2592-4a99-bdbd-55a21fc3ceb5...',
      content:
          'a bit of a narrow toebox not wide by any stretch, half size up if you are wide the quality of the made in india marked boxes have be...',
    ),
    Review(
      title: 'Great shoes',
      rating: 5,
      id: 'e223a639-1f6a-4f52-b1c3-d2debb57e5ba...',
      content:
          'One of the best shoes. Honestly you can wear these things with about any outfit/ any color. Happy to have been purchasing Air f...',
    ),
    Review(
        title: 'Love the colors',
        rating: 4,
        id: 'e223a639-1f6a-4f52-b1c3-d2debb57e5ba...',
        content:
            "Happy to purchase these shoes but half size up if you are wide the quality of the..."),
  ];

  ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...reviews.map((review) => _buildReviewCard(context, review)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (review.title.isNotEmpty)
          Text(
            review.title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        const SizedBox(height: 8),
        RatingProductWidget(
          value: review.rating,
        ),
        const SizedBox(height: 8),
        Text(
          review.content,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class Review {
  final String title;
  final int rating;
  final String id;
  final String content;

  Review({
    required this.title,
    required this.rating,
    required this.id,
    required this.content,
  });
}
