import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/update.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final IAppRepository repository;
  UpdateCubit({required this.repository}) : super(UpdateLoading());

  Future<void> loadUpdatesFromServer() async {
    try {
      emit(UpdateLoading());
      final response = await repository.getUpdateList();
      response.fold(
        (l) {
          debugPrint("Update Loading Failure: ${l.failureMessage()}");
          emit(UpdateFailure(l.failureMessage()));
        },
        (r) async {
          debugPrint("Update Loading Success: ${r.message}");
          emit(UpdateLoaded(r.data!));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(UpdateFailure('An error occurred. Please try again.'));
    }
  }
}
