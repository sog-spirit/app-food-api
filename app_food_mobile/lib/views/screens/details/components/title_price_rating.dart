import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../../constants.dart';

class TitlePriceRating extends StatelessWidget {
  final String name;
  final double rating, price;
  final int numOfReviews;
  // final RatingChangeCallback onRatingChanged;

  const TitlePriceRating({
    Key? key,
    required this.rating,
    required this.numOfReviews,
    // required this.onRatingChanged,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline2,
              ),
              Row(
                children: [
                  // SmoothStarRating(
                  //   borderColor: kPrimaryColor,
                  //   rating: rating,
                  // ),
                  SizedBox(width: 10),
                  Text("${numOfReviews} reviews")
                ],
              )
            ],
          ),
        )),
        Container(
          child: Text(
            price.toInt().toVND().toString(),
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  ClipPath PriceTag(BuildContext context) {
    return ClipPath(
      clipper: PricerCliper(),
      child: Container(
        height: 66,
        width: 66,
        color: kPrimaryColor,
        child: Center(
          child: Text(
            "\$${price}",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
