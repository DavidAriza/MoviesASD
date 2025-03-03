import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_asd/presentation/cubits/movies_cubit/movies_cubit.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  const SearchField({
    super.key,
    required this.controller,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: TextField(
        controller: widget.controller,
        style: textTheme.bodyLarge,
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<MoviesCubit>().getMoviesList(reset: true);
          } else {
            context.read<MoviesCubit>().search(value);
          }
        },
        decoration: InputDecoration(
          prefixIcon: GestureDetector(
            onTap: () {
              context.read<MoviesCubit>().search(widget.controller.text);
            },
            child: const Icon(
              Icons.search_rounded,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              widget.controller.clear();
              context.read<MoviesCubit>().getMoviesList(reset: true);
              // context.read<SearchBloc>().add(const GetSearchResultsEvent(''));
            },
            child: const Icon(
              Icons.clear_rounded,
            ),
          ),
          hintText: 'Search',
          hintStyle: textTheme.bodyLarge,
        ),
      ),
    );
  }
}
