import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/language.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final IAppRepository repository;
  LanguageCubit({required this.repository}) : super(LanguageLoading());

  Future<void> loadLanguagesFromServer() async {
    try {
      emit(LanguageLoading());
      final response = await repository.getLanguageList();
      response.fold(
        (l) {
          debugPrint("Language Loading Failure: ${l.failureMessage()}");
          emit(LanguageFailure(l.failureMessage()));
        },
        (r) {
          debugPrint("Language Loading Success: ${r.message}");
          emit(LanguageLoaded(r.data!));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(LanguageFailure('An error occurred. Please try again.'));
    }
  }
}
