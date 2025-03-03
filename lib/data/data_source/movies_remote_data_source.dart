import 'package:dio/dio.dart';
import 'package:movies_asd/core/network/dio_http_client.dart';
import 'package:movies_asd/core/network/errors/error.dart';
import 'package:movies_asd/core/network/errors/exception.dart';
import 'package:movies_asd/data/models/actor_model.dart';
import 'package:movies_asd/data/models/movie_details_model.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies(int page);
  Future<List<MovieModel>> searchMovie(String query, int page);
  Future<MovieDetails> getMovieDetails(int id);
  Future<List<ActorModel>> getCast(int id);
  Future<List<MovieModel>> getSimilarMovies(int id);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpClient client;

  MoviesRemoteDataSourceImpl(this.client);

  @override
  Future<List<MovieModel>> getMovies(int page) async {
    try {
      final response = await client.get('/movie/now_playing', queryParameters: {'page': page});
      if (response.statusCode == 200 && response.data['results'] is List) {
        return (response.data['results'] as List).map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<MovieDetails> getMovieDetails(int id) async {
    try {
      final response = await client.get('/movie/$id');
      if (response.statusCode == 200) {
        return MovieDetailsModel.fromJson(response.data);
      } else {
        throw ErrorFailure.decode(response.data);
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<List<ActorModel>> getCast(int id) async {
    try {
      final response = await client.get('/movie/$id/credits');
      if (response.statusCode == 200 && response.data['cast'] is List) {
        return (response.data['cast'] as List).map((e) => ActorModel.fromJson(e)).toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<List<MovieModel>> searchMovie(String query, int page) async {
    try {
      final response = await client.get('/search/movie', queryParameters: {'query': query, 'page': page});
      if (response.statusCode == 200 && response.data['results'] is List) {
        return (response.data['results'] as List).map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int id) async {
    try {
      final response = await client.get(
        '/movie/$id/similar',
      );
      if (response.statusCode == 200 && response.data['results'] is List) {
        return (response.data['results'] as List).map((e) => MovieModel.fromJson(e)).toList();
      } else {
        throw const FormatException('Data is not a List');
      }
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
