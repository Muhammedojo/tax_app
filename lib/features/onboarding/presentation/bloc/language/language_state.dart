part of 'language_cubit.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final List<Language> languageList;

  const LanguageLoaded(this.languageList);

  @override
  List<Object> get props => [languageList];

  @override
  String toString() => 'LanguageLoaded { Languages: $languageList }';
}

class LanguageNotLoaded extends LanguageState {}

class LanguageFailure extends LanguageState {
  final String error;

  const LanguageFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LanguageFailure { error: $error }';
}
