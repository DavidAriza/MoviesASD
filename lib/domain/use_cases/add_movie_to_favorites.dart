import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';

class AddMovieToFavorites extends UseCase<Unit, Movie> {
  final LocalMoviesRepository localMoviesRepository;

  AddMovieToFavorites({required this.localMoviesRepository});

  @override
  Future<Either<Failure, Unit>> call(Movie movie) async {
    return await localMoviesRepository.addMovieToFavorites(movie);
  }
}
