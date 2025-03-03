import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_asd/data/data_source/local_movies_data_source.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/data/repositories/local_movies_repository_impl.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';

class MockLocalMoviesDataSource extends Mock implements LocalMoviesDataSource {}

void main() {
  late LocalMoviesRepository repository;
  late MockLocalMoviesDataSource mockLocalMoviesDataSource;

  setUpAll(() {
    registerFallbackValue(
      MovieModel(
        tmdbID: 0,
        title: '',
        overview: '',
        posterUrl: '',
        backdropUrl: '',
        releaseDate: '',
        voteAverage: 0.0,
      ),
    );
  });

  setUp(() {
    mockLocalMoviesDataSource = MockLocalMoviesDataSource();
    repository = LocalMoviesRepositoryImpl(localMoviesDataSource: mockLocalMoviesDataSource);
  });

  final tMovie = Movie(
    tmdbID: 1,
    title: 'Inception',
    overview: 'A mind-bending thriller',
    posterUrl: '/poster.jpg',
    backdropUrl: '/backdrop.jpg',
    releaseDate: '2010-07-16',
    voteAverage: 8.3,
  );

  final tMovieModel = MovieModel.fromEntity(tMovie);

  group('LocalMoviesRepository', () {
    test('getFavoriteMovies should return a list of type Movie', () {
      // Arrange
      when(() => mockLocalMoviesDataSource.getFavoriteMovies()).thenReturn([tMovieModel]);

      // Act
      final result = repository.getFavoriteMovies();

      // Assert
      expect(result, isA<Right>());
      verify(() => mockLocalMoviesDataSource.getFavoriteMovies()).called(1);
    });

    test('addMovieToFavorites should return Unit when its added correctly', () async {
      // Arrange
      when(() => mockLocalMoviesDataSource.addMovieToFavorites(any())).thenAnswer((_) async {});

      // Act
      final result = await repository.addMovieToFavorites(tMovie);

      // Assert
      expect(result, Right(unit));
      verify(() => mockLocalMoviesDataSource.addMovieToFavorites(tMovieModel)).called(1);
    });

    test('removeMovieFromFavorites should return Unit when its deleted correctly', () async {
      // Arrange
      when(() => mockLocalMoviesDataSource.removeMovieFromFavorites(any())).thenAnswer((_) async {});

      // Act
      final result = await repository.removeMovieFromFavorites(tMovie.tmdbID);

      // Assert
      expect(result, Right(unit));
      verify(() => mockLocalMoviesDataSource.removeMovieFromFavorites(tMovie.tmdbID)).called(1);
    });

    test('isInFavorites should return the movie if its in favorites', () {
      // Arrange
      when(() => mockLocalMoviesDataSource.isInFavorites(any())).thenReturn(tMovieModel);

      // Act
      final result = repository.isInFavorites(tMovie.tmdbID);

      // Assert
      expect(result, Right(tMovie));
      verify(() => mockLocalMoviesDataSource.isInFavorites(tMovie.tmdbID)).called(1);
    });

    test('isInFavorites should return null if the movie its not in favorites', () {
      // Arrange
      when(() => mockLocalMoviesDataSource.isInFavorites(any())).thenReturn(null);

      // Act
      final result = repository.isInFavorites(tMovie.tmdbID);

      // Assert
      expect(result, Right(null));
      verify(() => mockLocalMoviesDataSource.isInFavorites(tMovie.tmdbID)).called(1);
    });
  });
}
