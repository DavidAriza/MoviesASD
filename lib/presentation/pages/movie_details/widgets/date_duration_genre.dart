import 'package:flutter/material.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';

class MovieDurationDateGenre extends StatelessWidget {
  const MovieDurationDateGenre({
    super.key,
    required this.movieDetails,
  });

  final MovieDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (movieDetails.releaseDate.isNotEmpty &&
        movieDetails.genres.isNotEmpty &&
        movieDetails.runtime!.isNotEmpty) {
      return Row(
        children: [
          if (movieDetails.releaseDate.isNotEmpty) ...[
            Text(
              movieDetails.releaseDate.split(',')[1] + ' - ',
              style: textTheme.bodyLarge,
            ),
          ],
          if (movieDetails.genres.isNotEmpty) ...[
            Text(
              movieDetails.genres + ' - ',
              style: textTheme.bodyLarge,
            ),
          ] else ...[
            if (movieDetails.runtime!.isNotEmpty) ...[]
          ],
          Text(
            movieDetails.runtime!,
            style: textTheme.bodyLarge,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
