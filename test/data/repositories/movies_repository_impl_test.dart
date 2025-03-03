import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_asd/data/data_source/movies_remote_data_source.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/data/repositories/movies_repository_impl.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';

import '../../mockresponse/t_response.dart';

class MockMoviesRemoteDataSource extends Mock implements MoviesRemoteDataSource {}

void main() {
  late MoviesRepository moviesRepository;

  late MockMoviesRemoteDataSource mockMoviesRemoteDataSource;

  setUp(
    () {
      mockMoviesRemoteDataSource = MockMoviesRemoteDataSource();
      moviesRepository = MoviesRepositoryImpl(remoteDataSource: mockMoviesRemoteDataSource);
    },
  );

  group(
    'Method getMovies',
    () {
      test(
        'should return a list of MovieModel when the response code is 200',
        () async {
          // arrange
          final page = 1;
          final tResponse = mockResponse['results']!
              .map(
                (e) => MovieModel.fromJson(e),
              )
              .toList();

          when(
            () => mockMoviesRemoteDataSource.getMovies(page),
          ).thenAnswer(
            (_) async => tResponse,
          );

          // act
          final result = await moviesRepository.getMovies(page);

          // assert
          verify(
            () => mockMoviesRemoteDataSource.getMovies(page),
          ).called(1);

          expect(result, Right(tResponse));
        },
      );

      test(
        'should throw a DioFailure when the call to the remote data source is unsuccessful',
        () async {
          // arrange
          final page = 1;
          final tException = DioException(
            requestOptions: RequestOptions(path: '/movie/now_playing'),
            response: Response(requestOptions: RequestOptions(path: '/movie/now_playing'), statusCode: 400),
          );

          when(
            () => mockMoviesRemoteDataSource.getMovies(page),
          ).thenThrow(
            tException,
          );

          // act
          final result = await moviesRepository.getMovies(page);

          // assert
          verify(
            () => mockMoviesRemoteDataSource.getMovies(page),
          ).called(1);

          expect(result, tException);
        },
      );
    },
  );
}
