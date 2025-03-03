import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';

class IsInFavorites implements UseCase<Movie?, int> {
  final LocalMoviesRepository localMoviesRepository;

  IsInFavorites({required this.localMoviesRepository});

  @override
  Future<Either<Failure, Movie?>> call(int movieId) async {
    return Future.value(localMoviesRepository.isInFavorites(movieId));
  }
}
