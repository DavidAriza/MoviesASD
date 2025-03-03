import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_asd/domain/entities/movie.dart';

class SimilarMovies extends StatelessWidget {
  final List<Movie> similarMovies;
  const SimilarMovies({super.key, required this.similarMovies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Similar movies',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: size.height * 0.35,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                bottom: 30,
                top: 15,
              ),
              itemCount: similarMovies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = similarMovies[index];
                return Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                      imageUrl: movie.posterUrl, width: 220, height: size.height * 0.35, fit: BoxFit.cover),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 15),
            ),
          ),
        ],
      ),
    );
  }
}
