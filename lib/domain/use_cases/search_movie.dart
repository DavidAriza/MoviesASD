import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';

class SearchMovie implements UseCase<List<Movie>, SearchMovieParams> {
  final MoviesRepository moviesRepository;

  SearchMovie({required this.moviesRepository});

  @override
  Future<Either<Failure, List<Movie>>> call(SearchMovieParams params) {
    return moviesRepository.searchMovie(params.query, params.page);
  }
}
