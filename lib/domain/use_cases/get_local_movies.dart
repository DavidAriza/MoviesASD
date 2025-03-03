import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';

class GetLocalMovies implements UseCase<List<Movie>, NoParameters> {
  final LocalMoviesRepository localMoviesRepository;

  GetLocalMovies({required this.localMoviesRepository});

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters noParams) async {
    return Future.value(localMoviesRepository.getFavoriteMovies());
  }
}
