import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/domain/entities/movie.dart';

abstract class LocalMoviesDataSource {
  List<MovieModel> getFavoriteMovies();
  Future<void> addMovieToFavorites(MovieModel item);
  Future<void> removeMovieFromFavorites(int id);
  MovieModel? isInFavorites(int id);
}

class LocalMoviesDataSourceImpl implements LocalMoviesDataSource {
  final Box<Movie> _moviesBox = Hive.box<Movie>('movies');

  @override
  List<MovieModel> getFavoriteMovies() {
    return _moviesBox.values.map((e) => MovieModel.fromEntity(e)).toList().reversed.toList();
  }

  @override
  Future<void> addMovieToFavorites(MovieModel item) async {
    await _moviesBox.put(item.tmdbID, item);
  }

  @override
  Future<void> removeMovieFromFavorites(int id) async {
    await _moviesBox.delete(id);
  }

  @override
  MovieModel? isInFavorites(int id) {
    try {
      if (_moviesBox.isEmpty) return null;

      final exists = _moviesBox.values.any((element) => element.tmdbID == id);

      if (!exists) return null;

      // Si existe, ahora podemos usar firstWhere con seguridad
      Movie movie = _moviesBox.values.firstWhere((element) => element.tmdbID == id);
      return MovieModel.fromEntity(movie);
    } catch (e) {
      return null;
    }
  }
}
