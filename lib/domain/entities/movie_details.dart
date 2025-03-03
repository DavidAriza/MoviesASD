import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MovieDetails extends Equatable {
  final int tmdbID;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String releaseDate;
  final String genres;
  final String? runtime;
  final int? numberOfSeasons;
  final String overview;
  final double voteAverage;
  final String voteCount;
  bool isAdded;

  MovieDetails({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.genres,
    this.runtime,
    this.numberOfSeasons,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    this.isAdded = false,
  });

  MovieDetails copyWith({
    int? tmdbID,
    String? title,
    String? posterUrl,
    String? backdropUrl,
    String? releaseDate,
    String? genres,
    String? runtime,
    int? numberOfSeasons,
    String? overview,
    double? voteAverage,
    String? voteCount,
    bool? isAdded,
  }) {
    return MovieDetails(
      tmdbID: tmdbID ?? this.tmdbID,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      backdropUrl: backdropUrl ?? this.backdropUrl,
      releaseDate: releaseDate ?? this.releaseDate,
      genres: genres ?? this.genres,
      runtime: runtime ?? this.runtime,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      overview: overview ?? this.overview,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      isAdded: isAdded ?? this.isAdded,
    );
  }

  @override
  List<Object?> get props => [
        tmdbID,
        title,
        posterUrl,
        backdropUrl,
        releaseDate,
        genres,
        overview,
        voteAverage,
        voteCount,
        isAdded,
      ];
}
