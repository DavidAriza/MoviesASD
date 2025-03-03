import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:movies_asd/data/data_source/local_movies_data_source.dart';

import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/domain/entities/movie.dart';

void main() {
  late LocalMoviesDataSource dataSource;
  late Box<Movie> moviesBox;

  setUp(() async {
    await setUpTestHive();
    Hive.registerAdapter(MovieAdapter());
    moviesBox = await Hive.openBox<Movie>('movies');
    dataSource = LocalMoviesDataSourceImpl();
  });

  tearDown(() async {
    await moviesBox.close();
  });

  test('should add a movie to favorites', () async {
    // Arrange
    final tMovie = MovieModel(
        tmdbID: 1,
        title: 'Inception',
        overview: 'A mind-bending thriller',
        posterUrl: '/poster.jpg',
        backdropUrl: '/backdrop.jpg',
        releaseDate: '2010-07-16',
        voteAverage: 8.3);

    // Act
    await dataSource.addMovieToFavorites(tMovie);
    final result = dataSource.getFavoriteMovies();

    // Assert
    expect(result.length, 1);
    expect(result.first.title, 'Inception');
  });

  test('should remove a movie from favorites', () async {
    // Arrange
    final tMovie = MovieModel(
        tmdbID: 2,
        title: 'Interstellar',
        overview: 'A sci-fi masterpiece',
        posterUrl: '/poster2.jpg',
        backdropUrl: '/backdrop.jpg',
        releaseDate: '2010-07-16',
        voteAverage: 8.3);

    await dataSource.addMovieToFavorites(tMovie);

    // Act
    await dataSource.removeMovieFromFavorites(2);
    final result = dataSource.getFavoriteMovies();

    // Assert
    expect(result.isEmpty, true);
  });

  test('should check if a movie is in favorites', () async {
    // Arrange
    final tMovie = MovieModel(
        tmdbID: 3,
        title: 'The Dark Knight',
        overview: 'A legendary superhero film',
        posterUrl: '/poster3.jpg',
        backdropUrl: '/backdrop.jpg',
        releaseDate: '2010-07-16',
        voteAverage: 8.3);

    await dataSource.addMovieToFavorites(tMovie);

    // Act
    final result = dataSource.isInFavorites(3);

    // Assert
    expect(result, isNotNull);
    expect(result!.title, 'The Dark Knight');
  });

  test('should return null if a movie is not in favorites', () {
    // Act
    final result = dataSource.isInFavorites(99);

    // Assert
    expect(result, isNull);
  });
}
