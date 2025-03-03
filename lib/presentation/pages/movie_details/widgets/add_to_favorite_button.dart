import 'package:flutter/material.dart';
import 'package:movies_asd/core/constants/app_colors.dart';

class AddToFavoritesButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isFavorite;
  const AddToFavoritesButton({super.key, required this.onTap, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.pink : Theme.of(context).textTheme.bodyMedium!.color, size: 22),
    );
  }
}
