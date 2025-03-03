import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:movies_asd/domain/entities/movie_details.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends Equatable {
  @HiveField(0)
  final int tmdbID;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String posterUrl;
  @HiveField(3)
  final String backdropUrl;
  @HiveField(4)
  final double voteAverage;
  @HiveField(5)
  final String releaseDate;
  @HiveField(6)
  final String overview;

  const Movie({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  factory Movie.fromMediaDetails(MovieDetails mediaDetails) {
    return Movie(
      tmdbID: mediaDetails.tmdbID,
      title: mediaDetails.title,
      posterUrl: mediaDetails.posterUrl,
      backdropUrl: mediaDetails.backdropUrl,
      voteAverage: mediaDetails.voteAverage,
      releaseDate: mediaDetails.releaseDate,
      overview: mediaDetails.overview,
    );
  }

  @override
  List<Object?> get props => [
        tmdbID,
        title,
        posterUrl,
        backdropUrl,
        voteAverage,
        releaseDate,
        overview,
      ];
}
