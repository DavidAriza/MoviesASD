import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';

class GetMovieDetails extends UseCase<MovieDetails, int> {
  final MoviesRepository moviesRepository;

  GetMovieDetails({required this.moviesRepository});
  @override
  Future<Either<Failure, MovieDetails>> call(int id) async {
    return await moviesRepository.getMovieDetails(id);
  }
}
