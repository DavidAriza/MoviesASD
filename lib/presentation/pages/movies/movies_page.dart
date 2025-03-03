import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_asd/core/theme/theme_cubit/theme_cubit.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/presentation/cubits/movies_cubit/movies_cubit.dart';
import 'package:movies_asd/presentation/pages/movie_details/movie_details_page.dart';
import 'package:movies_asd/presentation/pages/movies/widgets/loading_indicator.dart';
import 'package:movies_asd/presentation/pages/movies/widgets/search_bar.dart';
import 'package:movies_asd/presentation/pages/movies/widgets/vertical_movie_card.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late ScrollController _scrollController;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    Future.microtask(() => context.read<MoviesCubit>().getMoviesList());
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          context.read<MoviesCubit>().loadMore();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 842
        ? 4
        : (screenWidth > 600 && screenWidth < 842)
            ? 3
            : 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          Switch(
              value: context.watch<ThemeCubit>().state,
              onChanged: (value) {
                context.read<ThemeCubit>().changeTheme(value);
              })
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state.status == MoviesStatus.loading || state.status == MoviesStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == MoviesStatus.error) {
            return Center(
              child: Text(state.message),
            );
          }
          return Column(
            children: [
              SearchField(
                controller: controller,
              ),
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<MoviesCubit>().getMoviesList(reset: true);
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: screenWidth > 600 ? 0.6 : 0.55,
                        ),
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          final movie = state.movies[index];
                          return VerticalMovieCard(
                            movie: movie,
                            onTap: () => _goToDetails(movie),
                          );
                        }, childCount: state.movies.length),
                      ),
                      state.status == MoviesStatus.isLoadingMore
                          ? LoadingIndicator()
                          : SliverToBoxAdapter(
                              child: const SizedBox.shrink(),
                            )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _goToDetails(Movie movie) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MovieDetailsPage(
              movieId: movie.tmdbID,
              title: movie.title,
              imageUrl: movie.posterUrl,
              backdropImage: movie.backdropUrl,
            )));
  }
}
