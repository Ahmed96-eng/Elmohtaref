import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingMethodWidget extends StatelessWidget {
  const RatingMethodWidget({
    Key? key,
    required this.width,
    required this.initialRating,
    this.onRatingUpdate,
    this.ignoreGestures = true,
  }) : super(key: key);

  final double width;
  final double? initialRating;
  final bool ignoreGestures;
  final ValueChanged<double>? onRatingUpdate;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: width * 0.08,
      initialRating: initialRating!,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ignoreGestures: ignoreGestures,
      itemPadding: EdgeInsets.symmetric(horizontal: width * 0.005),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate!,
    );
  }
}
