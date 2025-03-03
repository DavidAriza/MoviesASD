import 'package:movies_asd/core/utils/movie_utils.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';

// ignore: must_be_immutable
class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required super.tmdbID,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.genres,
    required super.runtime,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      tmdbID: json['id'],
      title: json['title'],
      posterUrl: getPosterUrl(json['poster_path']),
      backdropUrl: getBackdropUrl(json['backdrop_path']),
      releaseDate: getDate(json['release_date']),
      genres: getGenres(json['genres']),
      runtime: getLength(json['runtime']),
      overview: json['overview'] ?? '',
      voteAverage:
          double.parse((json['vote_average'] as double).toStringAsFixed(1)),
      voteCount: getVotesCount(json['vote_count']),
    );
  }
}
