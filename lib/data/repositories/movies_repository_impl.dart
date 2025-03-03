import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/data/data_source/movies_remote_data_source.dart';
import 'package:movies_asd/domain/entities/actor.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<Movie>>> getMovies(int page) async {
    try {
      final result = await remoteDataSource.getMovies(page);
      final movies = result
          .map(
            (e) => e.toEntity(),
          )
          .toList();
      return Right(movies);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetails(id);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Actor>>> getCast(int id) async {
    try {
      final result = await remoteDataSource.getCast(id);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovie(String query, int page) async {
    try {
      final result = await remoteDataSource.searchMovie(query, page);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getSimilarMovies(int id) async {
    try {
      final result = await remoteDataSource.getSimilarMovies(id);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
