import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/domain/entities/actor.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getMovies(int page);
  Future<Either<Failure, MovieDetails>> getMovieDetails(int id);
  Future<Either<Failure, List<Actor>>> getCast(int id);
  Future<Either<Failure, List<Movie>>> searchMovie(String query, int page);
  Future<Either<Failure, List<Movie>>> getSimilarMovies(int id);
}
