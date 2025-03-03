import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_asd/domain/entities/movie.dart';
import 'package:shimmer/shimmer.dart';

class VerticalMovieCardImage extends StatelessWidget {
  const VerticalMovieCardImage({
    super.key,
    required this.movie,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: (movie.posterUrl),
        height: width < 192 ? height * 0.75 : height * 0.8,
        width: width,
        fit: BoxFit.cover,
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            height: height * 0.75,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
