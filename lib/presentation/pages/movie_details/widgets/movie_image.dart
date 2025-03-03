import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_asd/core/constants/app_colors.dart';
import 'package:movies_asd/core/theme/theme_cubit/theme_cubit.dart';

class MovieImage extends StatelessWidget {
  const MovieImage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.width,
    required this.backdropImage,
  });

  final String imageUrl;
  final String backdropImage;
  final String title;
  final int id;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          if (width > 600)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(backdropImage),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: width > 600 ? BoxFit.contain : BoxFit.fitWidth,
            errorWidget: (_, __, ___) => const Icon(
              Icons.error,
              color: AppColors.error,
            ),
          ),
        ],
      ),
      title: Container(
        color:
            Theme.of(context).scaffoldBackgroundColor.withValues(alpha: context.watch<ThemeCubit>().state ? 0.8 : 0.4),
        padding: EdgeInsets.all(5),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      centerTitle: true,
    );
  }
}
