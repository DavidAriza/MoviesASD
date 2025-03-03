part of 'movies_cubit.dart';

enum MoviesStatus { initial, loading, loaded, error, isLoadingMore, noSearchResults }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<Movie> movies;
  final List<Movie> favoriteMovies;
  final List<Movie> similarMovies;
  final String message;
  final bool? hasReachedMax;
  final MovieDetails? movieDetails;
  final List<Actor> cast;

  const MoviesState(
      {this.movies = const [],
      this.favoriteMovies = const [],
      this.similarMovies = const [],
      this.status = MoviesStatus.loading,
      this.message = '',
      this.hasReachedMax = false,
      this.movieDetails,
      this.cast = const []});

  MoviesState copyWith(
      {List<Movie>? movies,
      MoviesStatus? status,
      String? message,
      bool? hasReachedMax,
      MovieDetails? movieDetails,
      List<Movie>? favoriteMovies,
      List<Movie>? similarMovies,
      List<Actor>? cast}) {
    return MoviesState(
        movies: movies ?? this.movies,
        status: status ?? this.status,
        message: message ?? this.message,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        cast: cast ?? this.cast,
        movieDetails: movieDetails ?? this.movieDetails,
        favoriteMovies: favoriteMovies ?? this.favoriteMovies,
        similarMovies: similarMovies ?? this.similarMovies);
  }

  @override
  List<Object?> get props =>
      [movies, status, message, hasReachedMax, movieDetails, cast, favoriteMovies, similarMovies];
}
