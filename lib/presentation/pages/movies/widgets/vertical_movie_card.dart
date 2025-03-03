import 'package:flutter/material.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/presentation/pages/movies/widgets/vertical_movie_card_image.dart';

class VerticalMovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  const VerticalMovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(builder: (context, constraints) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              VerticalMovieCardImage(
                movie: movie,
                height: constraints.maxHeight,
                width: constraints.maxWidth,
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      movie.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(movie.releaseDate.split(',')[1]),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amberAccent,
                          size: 18,
                        ),
                        Text(
                          movie.voteAverage.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
