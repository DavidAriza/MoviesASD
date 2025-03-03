import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_asd/core/constants/app_colors.dart';
import 'package:movies_asd/injection_container.dart';
import 'package:movies_asd/presentation/cubits/movies_cubit/movies_cubit.dart';
import 'package:movies_asd/presentation/pages/favorite_movies/favorite_movies_page.dart';
import 'package:movies_asd/presentation/pages/movies/movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final index = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: index,
          builder: (context, child) {
            return IndexedStack(
              index: index.value,
              children: [MoviesPage(), FavoriteMoviesPage()],
            );
          }),
      bottomNavigationBar: ListenableBuilder(
          listenable: index,
          builder: (context, child) {
            return BottomNavigationBar(
              currentIndex: index.value,
              onTap: (value) {
                index.value = value;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.movie_creation_outlined,
                  ),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
              ],
              selectedItemColor: AppColors.pink,
            );
          }),
    );
  }
}
