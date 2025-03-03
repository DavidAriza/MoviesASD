import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_asd/core/network/dio_http_client.dart';
import 'package:movies_asd/core/network/errors/exception.dart';
import 'package:movies_asd/data/data_source/movies_remote_data_source.dart';
import 'package:movies_asd/data/models/movie_model.dart';

import '../../mockresponse/t_response.dart';

class MockDioHttpCliente extends Mock implements HttpClient {}

void main() {
  late MoviesRemoteDataSource moviesRemoteDataSource;
  late MockDioHttpCliente mockDioHttpCliente;

  setUp(() {
    mockDioHttpCliente = MockDioHttpCliente();
    moviesRemoteDataSource = MoviesRemoteDataSourceImpl(mockDioHttpCliente);
  });

  group('Method getMovies', () {
    test('should return a list of MovieModel when the response code is 200', () async {
      // arrange
      final page = 1;
      final tResponse = mockResponse;

      when(() => mockDioHttpCliente.get(
            '/movie/now_playing',
            queryParameters: {'page': page},
          )).thenAnswer((_) async => Response(
            data: tResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/movie/now_playing'),
          ));

      // act
      final result = await moviesRemoteDataSource.getMovies(page);

      // assert
      verify(() => mockDioHttpCliente.get(
            '/movie/now_playing',
            queryParameters: {'page': page},
          )).called(1);

      expect(result, isA<List<MovieModel>>());
      expect(result.length, 20);
      expect(result.first.tmdbID, 950396);
      expect(result.first.title, 'The Gorge');
    });

    test('should throw a DioFailure when the response code is not 200', () async {
      // arrange
      final page = 1;
      final tException = DioException(
        requestOptions: RequestOptions(path: '/movie/now_playing'),
        response: Response(requestOptions: RequestOptions(path: '/movie/now_playing'), statusCode: 400),
      );

      when(() => mockDioHttpCliente.get(
            '/movie/now_playing',
            queryParameters: {'page': page},
          )).thenThrow(tException);

      // act & assert
      expect(
        () => moviesRemoteDataSource.getMovies(page),
        throwsA(isA<DioFailure>()),
      );
    });
  });
}
