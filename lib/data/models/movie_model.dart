import 'package:movies_asd/core/utils/movie_utils.dart';
import 'package:movies_asd/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.tmdbID,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.voteAverage,
    required super.releaseDate,
    required super.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        tmdbID: json['id'],
        title: json['title'],
        posterUrl: getPosterUrl(json['poster_path']),
        backdropUrl: getBackdropUrl(json['backdrop_path']),
        voteAverage: double.parse((json['vote_average']).toStringAsFixed(1)),
        releaseDate: getDate(json['release_date']),
        overview: json['overview'] ?? '',
      );

  factory MovieModel.fromEntity(Movie media) {
    return MovieModel(
      tmdbID: media.tmdbID,
      title: media.title,
      releaseDate: media.releaseDate,
      voteAverage: media.voteAverage,
      posterUrl: media.posterUrl,
      backdropUrl: media.backdropUrl,
      overview: media.overview,
    );
  }
  Movie toEntity() => Movie(
        tmdbID: tmdbID,
        title: title,
        posterUrl: posterUrl,
        backdropUrl: backdropUrl,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
        overview: overview,
      );
}
