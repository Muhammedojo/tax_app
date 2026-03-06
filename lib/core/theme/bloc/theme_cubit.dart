import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../storage/istorage.dart';


part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final LocalStorage _localStorage = GetIt.I.get<LocalStorage>();
  
  ThemeCubit() : super(ThemeState(selectedTheme: 'System', appliedTheme: 'System', isApplied: true)) {
    _loadSavedTheme();
  }

  Future<void> applyTheme() async {
    try {
      await _localStorage.setThemeSetting(state.selectedTheme);
      
      emit(ThemeState(
        selectedTheme: state.selectedTheme,
        appliedTheme: state.selectedTheme,
        isApplied: true,
      ));
      
    } catch (e) {
      emit(ThemeState(
        selectedTheme: state.selectedTheme,
        appliedTheme: state.appliedTheme,
        isApplied: state.isApplied,
      ));
    }
  }

  Future<void> refreshTheme() async {
    await _loadSavedTheme();
  }

  void selectTheme(String theme) {
    emit(ThemeState(
      selectedTheme: theme,
      appliedTheme: state.appliedTheme,
      isApplied: false,
    ));
  }

  Future<void> _loadSavedTheme() async {
    try {
      final savedTheme = await _localStorage.getThemeSetting();
      
      if (savedTheme != null && savedTheme.isNotEmpty) {
        emit(ThemeState(
          selectedTheme: savedTheme,
          appliedTheme: savedTheme,
          isApplied: true,
        ));
      } else {
        emit(ThemeState(
          selectedTheme: 'System',
          appliedTheme: 'System',
          isApplied: true,
        ));
      }
    } catch (e) {
      emit(ThemeState(
        selectedTheme: 'System',
        appliedTheme: 'System',
        isApplied: true,
      ));
    }
  }
} 