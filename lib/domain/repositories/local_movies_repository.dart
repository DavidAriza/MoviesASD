import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/domain/entities/movie.dart';

abstract class LocalMoviesRepository {
  Either<Failure, List<Movie>> getFavoriteMovies();
  Future<Either<Failure, Unit>> addMovieToFavorites(Movie item);
  Future<Either<Failure, Unit>> removeMovieFromFavorites(int id);
  Either<Failure, Movie?> isInFavorites(int id);
}
