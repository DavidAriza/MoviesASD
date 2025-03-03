import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';

class RemoveMovieFromFavorites implements UseCase<Unit, int> {
  final LocalMoviesRepository localMoviesRepository;

  RemoveMovieFromFavorites({required this.localMoviesRepository});

  @override
  Future<Either<Failure, Unit>> call(int movieId) async {
    return await localMoviesRepository.removeMovieFromFavorites(movieId);
  }
}
