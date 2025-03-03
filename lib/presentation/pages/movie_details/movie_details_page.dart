import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_asd/domain/entities/movie.dart';

import 'package:movies_asd/injection_container.dart';
import 'package:movies_asd/presentation/cubits/movies_cubit/movies_cubit.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/add_to_favorite_button.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/cast.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/date_duration_genre.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/leading_movie_details.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/movie_image.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/overview.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/rating.dart';
import 'package:movies_asd/presentation/pages/movie_details/widgets/similar_movies.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String imageUrl;
  final String title;
  final String backdropImage;
  const MovieDetailsPage(
      {super.key, required this.movieId, required this.imageUrl, required this.title, required this.backdropImage});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: sl<MoviesCubit>()..getMovieDetailsById(widget.movieId),
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            forceElevated: true,
            expandedHeight: size.width > 600 ? size.height * 0.6 : size.height * 0.4,
            leading: LeadingMovieDetails(),
            flexibleSpace: MovieImage(
              imageUrl: widget.imageUrl,
              title: widget.title,
              id: widget.movieId,
              width: size.width,
              backdropImage: widget.backdropImage,
            ),
          ),
          BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              if (state.status == MoviesStatus.loading || state.status == MoviesStatus.initial) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: size.height * 0.6,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 6, right: 15, left: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MovieDurationDateGenre(movieDetails: state.movieDetails!),
                          Row(
                            children: [
                              if (Platform.isAndroid)
                                IconButton(
                                    onPressed: () async {
                                      await context.read<MoviesCubit>().downloadImage(widget.imageUrl, widget.title);
                                    },
                                    icon: Icon(Icons.share)),
                              AddToFavoritesButton(
                                  onTap: () => _handleFavoriteButtonTap(context, state),
                                  isFavorite: state.movieDetails!.isAdded),
                            ],
                          ),
                        ],
                      ),
                      Rating(movieDetails: state.movieDetails!),
                      Overview(
                        overview: state.movieDetails!.overview,
                      ),
                      Cast(
                        cast: state.cast,
                      ),
                      SimilarMovies(similarMovies: state.similarMovies)
                    ],
                  ),
                ),
              );
            },
          )
        ],
      )),
    );
  }

  void _handleFavoriteButtonTap(BuildContext context, MoviesState state) {
    if (state.movieDetails!.isAdded) {
      context.read<MoviesCubit>().removeMovieFromFavoritesList(state.movieDetails!.tmdbID);
    } else {
      context.read<MoviesCubit>().addFavoriteMovieToList(Movie.fromMediaDetails(state.movieDetails!));
    }
  }
}
