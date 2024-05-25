import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/DisplayReviewModel.dart';

class AllReviewsScreen extends StatelessWidget {
  final List<DisplayReviewModel> reviews;

  AllReviewsScreen({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: ReviewItem(review: review),
          );
        },
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final DisplayReviewModel review;

  ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.fullName ?? 'No Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  review.dated != null
                      ? '${review.dated!.day}/${review.dated!.month}/${review.dated!.year}'
                      : 'No Date',
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                review.review ?? 'No Review',
              ),
            ),
            RatingBarIndicator(
              rating: review.rating != null ? review.rating!.toDouble() : 0.0,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 30.0,
              direction: Axis.horizontal,
            ),
          ],
        ),
      ),
    );
  }
}
