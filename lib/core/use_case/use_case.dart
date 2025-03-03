import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:movies_asd/core/network/errors/failure.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P p);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}

class SearchMovieParams {
  final int page;
  final String query;

  SearchMovieParams({required this.page, required this.query});
}
