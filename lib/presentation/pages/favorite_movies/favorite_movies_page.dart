import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/presentation/pages/favorite_movies/widgets/favorite_movie_card.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite movies'),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Movie>('movies').listenable(),
          builder: (context, box, widget) {
            return box.values.isEmpty
                ? Center(
                    child: Text('There are no favorite movies to show...'),
                  )
                : screenWidth > 600
                    ? _FavoritesGridView(favorites: box.values.toList())
                    : _FavoritesListView(favorites: box.values.toList());
          }),
    );
  }
}

class _FavoritesListView extends StatelessWidget {
  final List<Movie> favorites;
  const _FavoritesListView({
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return FavoriteMovieCard(movie: movie);
      },
    );
  }
}

class _FavoritesGridView extends StatelessWidget {
  final List<Movie> favorites;

  const _FavoritesGridView({required this.favorites});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 842 ? 3 : 2;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.4,
        crossAxisCount: crossAxisCount,
      ),
      itemCount: favorites.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = favorites[index];
        return FavoriteMovieCard(movie: movie);
      },
    );
  }
}
