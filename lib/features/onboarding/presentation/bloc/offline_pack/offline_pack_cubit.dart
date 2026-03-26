import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/offline_pack.dart';

part 'offline_pack_state.dart';

class OfflinePackCubit extends Cubit<OfflinePackState> {
  final IAppRepository repository;
  OfflinePackCubit({required this.repository}) : super(OfflinePackLoading());

  Future<void> loadOfflinePackFromServer() async {
    try {
      emit(OfflinePackLoading());
      final response = await repository.getOfflinePack();
      response.fold(
        (l) {
          debugPrint("Offline Pack Loading Failure: ${l.failureMessage()}");
          emit(OfflinePackFailure(l.failureMessage()));
        },
        (r) async {
          debugPrint("Offline Pack Loading Success: ${r.message}");
          emit(OfflinePackLoaded(r.data!));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(OfflinePackFailure('An error occurred. Please try again.'));
    }
  }
}
