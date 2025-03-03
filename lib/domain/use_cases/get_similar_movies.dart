import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';

class GetSimilarMovies extends UseCase<List<Movie>, int> {
  final MoviesRepository moviesRepository;

  GetSimilarMovies({required this.moviesRepository});
  @override
  Future<Either<Failure, List<Movie>>> call(int id) async {
    return await moviesRepository.getSimilarMovies(id);
  }
}
