import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:movies_asd/core/use_case/use_case.dart';
import 'package:movies_asd/core/utils/debouncer.dart';
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
import 'package:path_provider/path_provider.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMovies getMovies;
  final GetMovieDetails getMovieDetails;
  final GetCast getCast;
  final GetLocalMovies getLocalMovies;
  final AddMovieToFavorites addMovieToFavorites;
  final RemoveMovieFromFavorites removeMovieFromFavorites;
  final IsInFavorites isInFavorites;
  final SearchMovie searchMovie;
  final GetSimilarMovies getSimilarMovies;
  MoviesCubit(this.getMovies, this.getMovieDetails, this.getCast, this.getLocalMovies, this.addMovieToFavorites,
      this.removeMovieFromFavorites, this.isInFavorites, this.searchMovie, this.getSimilarMovies)
      : super(MoviesState());

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  int _page = 1;

  static const platform = MethodChannel('com.example.movies_asd/share');
  final Dio dio = Dio();
  String? imagePath;

  void getMoviesList({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _searchPage = 1;
    }
    emit(state.copyWith(status: MoviesStatus.loading));
    final result = await getMovies.call(_page);
    result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)), (movies) {
      if (movies.isNotEmpty) {
        _page++;
        emit(state.copyWith(status: MoviesStatus.loaded, movies: movies));
      }
    });
  }

  int _searchPage = 1;
  void search(String query) {
    _debouncer.run(() => _performSearch(query));
  }

  void _performSearch(String query) async {
    if (query.isNotEmpty) {
      List<Movie> results =
          state.movies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();
      if (results.isNotEmpty) {
        emit(state.copyWith(status: MoviesStatus.loaded, movies: results));
      } else {
        emit(state.copyWith(
          status: MoviesStatus.loading,
        ));

        final result = await searchMovie.call(SearchMovieParams(query: query, page: _searchPage));
        result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)), (movies) {
          if (movies.isNotEmpty) {
            _searchPage++;
            emit(state.copyWith(status: MoviesStatus.loaded, movies: movies));
          } else {
            emit(state.copyWith(
              status: MoviesStatus.noSearchResults,
              message: 'No results found',
            ));
          }
        });
      }
    } else {}
  }

  clearSearch() {
    getMoviesList();
  }

  void loadMore() async {
    if (state.hasReachedMax!) return;
    emit(state.copyWith(status: MoviesStatus.isLoadingMore));
    final result = await getMovies.call(_page);
    result.fold(
        (failure) => emit(
              state.copyWith(status: MoviesStatus.error, message: failure.message),
            ), (movies) {
      if (movies.isNotEmpty) {
        _page++;
        emit(state.copyWith(status: MoviesStatus.loaded, movies: List.of(state.movies)..addAll(movies)));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
          status: MoviesStatus.loaded,
        ));
      }
    });
  }

  Future<void> getMovieDetailsById(int id) async {
    emit(state.copyWith(status: MoviesStatus.loading));
    final result = await getMovieDetails.call(id);
    result.fold(
        (failure) => emit(
              state.copyWith(status: MoviesStatus.error, message: failure.message),
            ), (movieDetails) {
      emit(state.copyWith(
        movieDetails: movieDetails,
      ));
      checkIfMovieIsInFavorites(id);
      getMovieCast(id);
      getSimilarMovieList(id);
    });
  }

  void getMovieCast(int id) async {
    final result = await getCast.call(id);

    result.fold(
        (failure) => emit(
              state.copyWith(status: MoviesStatus.error, message: failure.message),
            ),
        (cast) => emit(state.copyWith(cast: cast, status: MoviesStatus.loaded)));
  }

  void getFavoriteMovies() async {
    final result = await getLocalMovies.call(NoParameters());
    result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)),
        (favoriteMovies) => emit(state.copyWith(favoriteMovies: favoriteMovies, status: MoviesStatus.loaded)));
  }

  void addFavoriteMovieToList(Movie movie) async {
    final result = await addMovieToFavorites.call(movie);
    result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)), (unit) {
      getFavoriteMovies();
      emit(state.copyWith(movieDetails: state.movieDetails!.copyWith(isAdded: true)));
    });
  }

  void removeMovieFromFavoritesList(int id) async {
    emit(state.copyWith(status: MoviesStatus.loading));
    final result = await removeMovieFromFavorites.call(id);
    result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)), (unit) {
      getFavoriteMovies();
    });
  }

  void checkIfMovieIsInFavorites(int id) async {
    final result = await isInFavorites.call(id);
    result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)), (movie) {
      emit(
        state.copyWith(movieDetails: state.movieDetails!.copyWith(isAdded: movie != null ? true : false)),
      );
    });
  }

  void getSimilarMovieList(int id) async {
    final result = await getSimilarMovies.call(id);
    result.fold((failure) => emit(state.copyWith(status: MoviesStatus.error, message: failure.message)),
        (similarMovies) {
      emit(state.copyWith(status: MoviesStatus.loaded, similarMovies: similarMovies));
    });
  }

  Future<void> downloadImage(String imageUrl, String title) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/movie_image-$title.jpg';

      await dio.download(imageUrl, filePath);

      imagePath = filePath;
      await shareMovie(title);
    } catch (e) {}
  }

  Future<void> shareMovie(String title) async {
    if (imagePath == null) {
      return;
    }

    try {
      await platform.invokeMethod('share', {
        "title": title,
        "imagePath": imagePath,
      });
    } on PlatformException catch (e) {}
  }
}
