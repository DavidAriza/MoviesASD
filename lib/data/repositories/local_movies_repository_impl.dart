import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_asd/core/network/errors/exception.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/data/data_source/local_movies_data_source.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';

class LocalMoviesRepositoryImpl implements LocalMoviesRepository {
  final LocalMoviesDataSource localMoviesDataSource;

  LocalMoviesRepositoryImpl({required this.localMoviesDataSource});

  @override
  Either<Failure, List<Movie>> getFavoriteMovies() {
    try {
      final result = localMoviesDataSource.getFavoriteMovies();
      final movies = result.map((e) => e.toEntity()).toList();
      return Right(movies);
    } on HiveFailure catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMovieToFavorites(Movie item) async {
    try {
      final movieModel = MovieModel.fromEntity(item);
      localMoviesDataSource.addMovieToFavorites(movieModel);
      return Right(unit);
    } on HiveError catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeMovieFromFavorites(int id) async {
    try {
      await localMoviesDataSource.removeMovieFromFavorites(id);
      return Right(unit);
    } on HiveError catch (e) {
      return Left(HiveFailure(e.message));
    }
  }

  @override
  Either<Failure, Movie?> isInFavorites(int id) {
    try {
      return Right(localMoviesDataSource.isInFavorites(id)?.toEntity());
    } on HiveError catch (e) {
      return Left(HiveFailure(e.message));
    }
  }
}
