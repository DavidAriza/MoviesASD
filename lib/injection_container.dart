import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_asd/core/constants/api_constants.dart';
import 'package:movies_asd/core/network/dio_http_client.dart';
import 'package:movies_asd/data/data_source/local_movies_data_source.dart';
import 'package:movies_asd/data/data_source/movies_remote_data_source.dart';
import 'package:movies_asd/data/repositories/local_movies_repository_impl.dart';
import 'package:movies_asd/data/repositories/movies_repository_impl.dart';
import 'package:movies_asd/domain/repositories/local_movies_repository.dart';
import 'package:movies_asd/domain/repositories/movies_repository.dart';
import 'package:movies_asd/domain/use_cases/add_movie_to_favorites.dart';
import 'package:movies_asd/domain/use_cases/get_cast.dart';
import 'package:movies_asd/domain/use_cases/get_local_movies.dart';
import 'package:movies_asd/domain/use_cases/get_movie_details.dart';
import 'package:movies_asd/domain/use_cases/get_movies.dart';
import 'package:movies_asd/domain/use_cases/get_similar_movies.dart';
import 'package:movies_asd/domain/use_cases/is_In_favorites.dart';
import 'package:movies_asd/domain/use_cases/remove_movie_from_favorites.dart';
import 'package:movies_asd/domain/use_cases/search_movie.dart';
import 'package:movies_asd/presentation/cubits/movies_cubit/movies_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubits
  sl.registerFactory(() => MoviesCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));

  //use cases
  sl.registerLazySingleton<GetMovies>(() => GetMovies(moviesRepository: sl()));
  sl.registerLazySingleton<GetMovieDetails>(
    () => GetMovieDetails(moviesRepository: sl()),
  );
  sl.registerLazySingleton<GetCast>(() => GetCast(moviesRepository: sl()));
  sl.registerLazySingleton<GetLocalMovies>(() => GetLocalMovies(localMoviesRepository: sl()));
  sl.registerLazySingleton<AddMovieToFavorites>(() => AddMovieToFavorites(localMoviesRepository: sl()));
  sl.registerLazySingleton<RemoveMovieFromFavorites>(() => RemoveMovieFromFavorites(localMoviesRepository: sl()));
  sl.registerLazySingleton<IsInFavorites>(() => IsInFavorites(localMoviesRepository: sl()));
  sl.registerLazySingleton<SearchMovie>(() => SearchMovie(moviesRepository: sl()));
  sl.registerLazySingleton<GetSimilarMovies>(() => GetSimilarMovies(moviesRepository: sl()));

  //moviesRepository
  sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<LocalMoviesRepository>(() => LocalMoviesRepositoryImpl(localMoviesDataSource: sl()));

  //remote data
  sl.registerLazySingleton<MoviesRemoteDataSource>(() => MoviesRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<LocalMoviesDataSource>(() => LocalMoviesDataSourceImpl());

  //external
  sl.registerLazySingleton<HttpClient>(() => DioHttpClientImplementation(sl()));
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'accept': 'application/json', "Authorization": "Bearer ${ApiConstants.token}"})));
}
