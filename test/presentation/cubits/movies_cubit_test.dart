import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_asd/core/network/errors/failure.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/core/utils/movie_utils.dart';
import 'package:movies_asd/data/models/movie_model.dart';
import 'package:movies_asd/domain/entities/actor.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';
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

import '../../mockresponse/t_response.dart';

class MockFailure extends Failure {
  final String message;

  MockFailure(this.message);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MockFailure && runtimeType == other.runtimeType && message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class MockGetMovies extends Mock implements GetMovies {}

class MockGetMovieDetails extends Mock implements GetMovieDetails {}

class MockGetCast extends Mock implements GetCast {}

class MockGetLocalMovies extends Mock implements GetLocalMovies {}

class MockAddMovieToFavorites extends Mock implements AddMovieToFavorites {}

class MockRemoveMovieFromFavorites extends Mock implements RemoveMovieFromFavorites {}

class MockIsInFavorites extends Mock implements IsInFavorites {}

class MockSearchMovie extends Mock implements SearchMovie {}

class MockGetSimilarMovies extends Mock implements GetSimilarMovies {}

class FakeSearchMovieParams extends Fake implements SearchMovieParams {}

void main() {
  late MoviesCubit moviesCubit;
  late MockGetMovies mockGetMovies;
  late MockGetMovieDetails mockGetMovieDetails;
  late MockGetCast mockGetCast;
  late MockGetLocalMovies mockGetLocalMovies;
  late MockAddMovieToFavorites mockAddMovieToFavorites;
  late MockRemoveMovieFromFavorites mockRemoveMovieFromFavorites;
  late MockIsInFavorites mockIsInFavorites;
  late MockSearchMovie mockSearchMovie;
  late MockGetSimilarMovies mockGetSimilarMovies;

  setUpAll(() {
    registerFallbackValue(FakeSearchMovieParams());
  });

  setUp(() {
    mockGetMovies = MockGetMovies();
    mockGetMovieDetails = MockGetMovieDetails();
    mockGetCast = MockGetCast();
    mockGetLocalMovies = MockGetLocalMovies();
    mockAddMovieToFavorites = MockAddMovieToFavorites();
    mockRemoveMovieFromFavorites = MockRemoveMovieFromFavorites();
    mockIsInFavorites = MockIsInFavorites();
    mockSearchMovie = MockSearchMovie();
    mockGetSimilarMovies = MockGetSimilarMovies();

    moviesCubit = MoviesCubit(
      mockGetMovies,
      mockGetMovieDetails,
      mockGetCast,
      mockGetLocalMovies,
      mockAddMovieToFavorites,
      mockRemoveMovieFromFavorites,
      mockIsInFavorites,
      mockSearchMovie,
      mockGetSimilarMovies,
    );
  });

  final tMovieNoMatch = MovieModel(
    tmdbID: 3,
    title: 'No Match',
    overview: 'Overview 3',
    posterUrl: 'poster3.jpg',
    backdropUrl: 'backdrop3.jpg',
    voteAverage: 8.0,
    releaseDate: '2021-03-03',
  );

  final tMovieMatch = Movie(
    backdropUrl: getBackdropUrl("/rOMLLMGgDgGG6XeT3P8sUdUb8nl.jpg"),
    tmdbID: 1126166,
    overview:
        "A U.S. Marshal escorts a government witness to trial after he's accused of getting involved with a mob boss, only to discover that the pilot who is transporting them is also a hitman sent to assassinate the informant. After they subdue him, they're forced to fly together after discovering that there are others attempting to eliminate them.",
    posterUrl: getPosterUrl("/q0bCG4NX32iIEsRFZqRtuvzNCyZ.jpg"),
    releaseDate: getDate("2025-01-22"),
    title: "Flight Risk",
    voteAverage: 6.0,
  );

  final tMovies = mockResponse['results']!
      .map(
        (e) => MovieModel.fromJson(e).toEntity(),
      )
      .toList();

  final tMovieDetails = MovieDetails(
      tmdbID: 1,
      title: 'Test Movie Details',
      overview: 'Overview Details',
      posterUrl: 'posterDetails.jpg',
      backdropUrl: 'backdropDetails.jpg',
      voteAverage: 7.5,
      releaseDate: '2021-01-01',
      genres: 'Action',
      isAdded: false,
      voteCount: '6.0');

  final tFailure = MockFailure('Error');

  final tCast = [
    Actor(name: 'Actor 1', profilePath: 'profile1.jpg', character: 'Character 1'),
    Actor(name: 'Actor 2', profilePath: 'profile2.jpg', character: 'Character 2'),
  ];

  group('getMoviesList', () {
    blocTest<MoviesCubit, MoviesState>(
      'should emit [loading, loaded] when getting movies is successful',
      build: () {
        when(() => mockGetMovies.call(any())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMoviesList(),
      expect: () => [
        MoviesState(status: MoviesStatus.loading),
        MoviesState(status: MoviesStatus.loaded, movies: tMovies),
      ],
      verify: (_) {
        verify(() => mockGetMovies.call(1)).called(1);
      },
    );

    blocTest<MoviesCubit, MoviesState>(
      'should emit [loading, error] when getting movies fails',
      build: () {
        when(() => mockGetMovies.call(any())).thenAnswer((_) async => Left(tFailure));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMoviesList(),
      expect: () => [
        MoviesState(status: MoviesStatus.loading),
        MoviesState(status: MoviesStatus.error, message: tFailure.message),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should reset page when reset is true',
      build: () {
        when(() => mockGetMovies.call(any())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMoviesList(reset: true),
      verify: (_) {
        verify(() => mockGetMovies.call(1)).called(1);
      },
    );
  });

  group('loadMore', () {
    blocTest<MoviesCubit, MoviesState>(
      'should emit [isLoadingMore, loaded] when loading more movies is successful',
      build: () {
        when(() => mockGetMovies.call(any())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      seed: () => MoviesState(status: MoviesStatus.loaded, movies: tMovies, hasReachedMax: false),
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        MoviesState(status: MoviesStatus.isLoadingMore, movies: tMovies, hasReachedMax: false),
        MoviesState(
          status: MoviesStatus.loaded,
          movies: [...tMovies, ...tMovies],
          hasReachedMax: false,
        ),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should emit [isLoadingMore, loaded with hasReachedMax=true] when no more movies are available',
      build: () {
        when(() => mockGetMovies.call(any())).thenAnswer((_) async => Right([]));
        return moviesCubit;
      },
      seed: () => MoviesState(status: MoviesStatus.loaded, movies: tMovies, hasReachedMax: false),
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        MoviesState(status: MoviesStatus.isLoadingMore, movies: tMovies, hasReachedMax: false),
        MoviesState(
          status: MoviesStatus.loaded,
          movies: tMovies,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should not call getMovies when hasReachedMax is true',
      build: () {
        return moviesCubit;
      },
      seed: () => MoviesState(status: MoviesStatus.loaded, movies: tMovies, hasReachedMax: true),
      act: (cubit) => cubit.loadMore(),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetMovies.call(any()));
      },
    );
  });

  group('getMovieDetailsById', () {
    const tMovieId = 1;

    blocTest<MoviesCubit, MoviesState>(
      'should emit [loading] and call getMovieDetails, isInFavorites, getCast, and getSimilarMovies',
      build: () {
        when(() => mockGetMovieDetails.call(any())).thenAnswer((_) async => Right(tMovieDetails));
        when(() => mockIsInFavorites.call(any())).thenAnswer((_) async => Right(null));
        when(() => mockGetCast.call(any())).thenAnswer((_) async => Right(tCast));
        when(() => mockGetSimilarMovies.call(any())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMovieDetailsById(tMovieId),
      verify: (_) {
        verify(() => mockGetMovieDetails.call(tMovieId)).called(1);
        verify(() => mockIsInFavorites.call(tMovieId)).called(1);
        verify(() => mockGetCast.call(tMovieId)).called(1);
        verify(() => mockGetSimilarMovies.call(tMovieId)).called(1);
      },
    );

    blocTest<MoviesCubit, MoviesState>(
      'should emit [loading, error] when getMovieDetails fails',
      build: () {
        when(() => mockGetMovieDetails.call(any())).thenAnswer((_) async => Left(tFailure));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMovieDetailsById(tMovieId),
      expect: () => [
        MoviesState(status: MoviesStatus.loading),
        MoviesState(status: MoviesStatus.error, message: tFailure.message),
      ],
    );
  });

  group('getMovieCast', () {
    const tMovieId = 1;

    blocTest<MoviesCubit, MoviesState>(
      'should emit state with cast and loaded status when successful',
      build: () {
        when(() => mockGetCast.call(any())).thenAnswer((_) async => Right(tCast));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMovieCast(tMovieId),
      expect: () => [
        MoviesState(status: MoviesStatus.loaded, cast: tCast),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should emit error status when getting cast fails',
      build: () {
        when(() => mockGetCast.call(any())).thenAnswer((_) async => Left(tFailure));
        return moviesCubit;
      },
      act: (cubit) => cubit.getMovieCast(tMovieId),
      expect: () => [
        MoviesState(status: MoviesStatus.error, message: tFailure.message),
      ],
    );
  });

  group('getFavoriteMovies', () {
    blocTest<MoviesCubit, MoviesState>(
      'should emit state with favoriteMovies and loaded status when successful',
      build: () {
        when(() => mockGetLocalMovies.call(NoParameters())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      act: (cubit) => cubit.getFavoriteMovies(),
      expect: () => [
        MoviesState(status: MoviesStatus.loaded, favoriteMovies: tMovies),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should emit error status when getting favorite movies fails',
      build: () {
        when(() => mockGetLocalMovies.call(NoParameters())).thenAnswer((_) async => Left(tFailure));
        return moviesCubit;
      },
      act: (cubit) => cubit.getFavoriteMovies(),
      expect: () => [
        MoviesState(status: MoviesStatus.error, message: tFailure.message),
      ],
    );
  });

  group('getSimilarMovieList', () {
    const tMovieId = 1;

    blocTest<MoviesCubit, MoviesState>(
      'should emit state with similarMovies and loaded status when successful',
      build: () {
        when(() => mockGetSimilarMovies.call(any())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      act: (cubit) => cubit.getSimilarMovieList(tMovieId),
      expect: () => [
        MoviesState(status: MoviesStatus.loaded, similarMovies: tMovies),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should emit error status when getting similar movies fails',
      build: () {
        when(() => mockGetSimilarMovies.call(any())).thenAnswer((_) async => Left(tFailure));
        return moviesCubit;
      },
      act: (cubit) => cubit.getSimilarMovieList(tMovieId),
      expect: () => [
        MoviesState(status: MoviesStatus.error, message: tFailure.message),
      ],
    );
  });

  group('search', () {
    const tQuery = 'Fli';

    blocTest<MoviesCubit, MoviesState>(
      'should emit state with local search results when matching movies are found locally',
      build: () {
        return moviesCubit;
      },
      seed: () => MoviesState(movies: tMovies),
      act: (cubit) async {
        cubit.search(tQuery);
        await Future.delayed(const Duration(milliseconds: 600));
      },
      expect: () => [
        MoviesState(
          status: MoviesStatus.loaded,
          movies: [
            tMovieMatch,
          ],
        ),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'should call searchMovie when no matching movies are found locally',
      build: () {
        when(() => mockSearchMovie.call(any())).thenAnswer((_) async => Right(tMovies));
        return moviesCubit;
      },
      seed: () => MoviesState(movies: [tMovieNoMatch]),
      act: (cubit) async {
        cubit.search(tQuery);
        await Future.delayed(const Duration(milliseconds: 600));
      },
      verify: (_) {
        verify(() => mockSearchMovie.call(any())).called(1);
      },
    );
  });
}
