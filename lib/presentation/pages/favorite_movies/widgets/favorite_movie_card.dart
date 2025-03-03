import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_asd/core/constants/app_colors.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/presentation/cubits/movies_cubit/movies_cubit.dart';

class FavoriteMovieCard extends StatelessWidget {
  final Movie movie;

  const FavoriteMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 40, 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    height: size.width > 600 ? size.height : 140,
                    width: size.width > 600 ? size.width / 6 : 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        movie.releaseDate.split(',')[1],
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toString(),
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.width > 600 ? constraints.maxHeight / 2 - 8 : 65,
            right: size.width > 600 ? 5 : 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () => _showRemoveDialog(context),
                child: Text(
                  'Remove',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  void _showRemoveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<MoviesCubit>(),
          child: AlertDialog(
            title: const Text('Remove movie'),
            content: const Text('Are you sure you want to remove this movie from favorites?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<MoviesCubit>().removeMovieFromFavoritesList(movie.tmdbID);
                  Navigator.of(context).pop();
                },
                child: const Text('Remove'),
              ),
            ],
          ),
        );
      },
    );
  }
}
