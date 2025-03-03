import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_asd/core/theme/app_theme.dart';
import 'package:movies_asd/core/theme/theme_cubit/theme_cubit.dart';
import 'package:movies_asd/domain/entities/movie.dart';

import 'package:movies_asd/presentation/pages/home_page/home_page.dart';
import 'package:movies_asd/injection_container.dart' as di;

import 'presentation/cubits/movies_cubit/movies_cubit.dart';

Future<void> main() async {
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('movies');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider(
          create: (context) =>
              MoviesCubit(di.sl(), di.sl(), di.sl(), di.sl(), di.sl(), di.sl(), di.sl(), di.sl(), di.sl()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDark) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: HomePage());
        },
      ),
    );
  }
}
