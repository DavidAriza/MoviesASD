import 'package:dartz/dartz.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/domain/entities/actor.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';

class GetCast extends UseCase<List<Actor>, int> {
  final MoviesRepository moviesRepository;

  GetCast({required this.moviesRepository});
  @override
  Future<Either<Failure, List<Actor>>> call(int id) async {
    return await moviesRepository.getCast(id);
  }
}
