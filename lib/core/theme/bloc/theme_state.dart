part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final String selectedTheme;
  final String appliedTheme;
  final bool isApplied;

  const ThemeState({
    required this.selectedTheme,
    required this.appliedTheme,
    required this.isApplied,
  });

  @override
  List<Object?> get props => [selectedTheme, appliedTheme, isApplied];

  ThemeState copyWith({
    String? selectedTheme,
    String? appliedTheme,
    bool? isApplied,
  }) {
    return ThemeState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      appliedTheme: appliedTheme ?? this.appliedTheme,
      isApplied: isApplied ?? this.isApplied,
    );
  }
} 