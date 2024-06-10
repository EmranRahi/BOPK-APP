import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Controllers/Api_Controller.dart';
import '../model/DisplayReviewModel.dart';

class AllReviewsScreen extends StatefulWidget {
  const AllReviewsScreen(this.karobarId, {Key? key}) : super(key: key);
  final int? karobarId;

  @override
  _AllReviewsScreenState createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends State<AllReviewsScreen> {
  List<DisplayReviewModel> reviews = []; // Declare reviews globally
  late Future<List<DisplayReviewModel>> futureReviews;

  @override
  void initState() {
    super.initState();
    futureReviews = APIController().fetchReviews(widget.karobarId!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Reviews'),
      ),
      body: FutureBuilder<List<DisplayReviewModel>>(
        future: futureReviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            reviews = snapshot.data ?? [];
            if (reviews.isEmpty) {
              return Center(
                child: Text('No reviews available.'),
              );
            } else {
              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: ReviewItem(review: review),
                  );
                },
              );
            }
          }
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
                  review.name ?? 'No Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  review.dateTime != null
                      ? '${review.dateTime!.day}/${review.dateTime!.month}/${review.dateTime!.year}'
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
