import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';
import 'package:movies_asd/domain/use_cases/get_movies.dart';

import '../../mockresponse/t_response.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

class MockRepositoryFailure extends Failure {
  final String message;

  MockRepositoryFailure(this.message);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MockRepositoryFailure && runtimeType == other.runtimeType && message == other.message;

  @override
  int get hashCode => message.hashCode;
}

void main() {
  late GetMovies getMoviesUseCase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    getMoviesUseCase = GetMovies(moviesRepository: mockMoviesRepository);
  });

  final tMovies = mockResponse['results']!
      .map(
        (e) => MovieModel.fromJson(e).toEntity(),
      )
      .toList();

  const tPage = 1;

  test('should obtain a list of Movie from the repository', () async {
    // Arrange
    when(() => mockMoviesRepository.getMovies(any())).thenAnswer((_) async => Right(tMovies));

    // Act
    final result = await getMoviesUseCase.call(tPage);

    // Assert
    expect(result, Right(tMovies));
    verify(() => mockMoviesRepository.getMovies(tPage)).called(1);
    verifyNoMoreInteractions(mockMoviesRepository);
  });

  test('should obtain a Failure when the repository fails', () async {
    // Arrange
    when(() => mockMoviesRepository.getMovies(any())).thenAnswer((_) async => Left(MockRepositoryFailure('Error')));

    // Act
    final result = await getMoviesUseCase.call(tPage);

    // Assert
    expect(result, Left(MockRepositoryFailure('Error')));
    verify(() => mockMoviesRepository.getMovies(tPage)).called(1);
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
