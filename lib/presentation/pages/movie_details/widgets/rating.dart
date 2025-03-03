import 'package:flutter/material.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';

class Rating extends StatelessWidget {
  final MovieDetails movieDetails;
  const Rating({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star_rate_rounded,
          color: Colors.amberAccent,
          size: 18,
        ),
        Text(
          '${movieDetails.voteAverage} ',
        ),
        Text(
          movieDetails.voteCount,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
