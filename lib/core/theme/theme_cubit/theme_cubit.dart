import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDark') ?? PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    emit(isDark);
  }

  void changeTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', value);
    emit(value);
  }
}
