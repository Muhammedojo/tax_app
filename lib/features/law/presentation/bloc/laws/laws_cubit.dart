import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/law.dart';

part 'laws_state.dart';

class LawsCubit extends Cubit<LawsState> {
  final IAppRepository repository;
  LawsCubit({required this.repository}) : super(LawsLoading());

  Future<void> loadLawsFromServer() async {
    try {
      emit(LawsLoading());
      final response = await repository.getLawList();
      response.fold(
        (l) {
          debugPrint("Laws Loading Failure: ${l.failureMessage()}");
          emit(LawsFailure(l.failureMessage()));
        },
        (r) async {
          debugPrint("Laws Loading Success: ${r.message}");
          emit(LawsLoaded(r.data!));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(LawsFailure('An error occurred. Please try again.'));
    }
  }
}
