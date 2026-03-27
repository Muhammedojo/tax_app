import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/offline_pack.dart';
import '../../../../../core/storage/istorage.dart';

part 'offline_pack_state.dart';

class OfflinePackCubit extends Cubit<OfflinePackState> {
  final IAppRepository repository;
  final LocalStorage storage;

  OfflinePackCubit({required this.repository, required this.storage})
      : super(OfflinePackInitial());

  Future<void> loadFromCache() async {
    try {
      final hasPack = await storage.hasOfflinePack();
      if (hasPack) {
        final json = await storage.getOfflinePack();
        if (json != null) {
          final pack = OfflinePack.fromJson(
            jsonDecode(json) as Map<String, dynamic>,
          );
          emit(OfflinePackLoaded(pack));
          return;
        }
      }
      emit(OfflinePackInitial());
    } catch (e) {
      debugPrint("Cache load error: ${e.toString()}");
      emit(OfflinePackInitial());
    }
  }

  Future<void> downloadFromServer() async {
    try {
      emit(OfflinePackLoading());
      final response = await repository.getOfflinePack();
      response.fold(
        (l) {
          debugPrint("Offline Pack Failure: ${l.failureMessage()}");
          emit(OfflinePackFailure(l.failureMessage()));
        },
        (r) async {
          debugPrint("Offline Pack Success: ${r.message}");
          final pack = r.data!;
          await storage.saveOfflinePack(jsonEncode(pack.toJson()));
          emit(OfflinePackLoaded(pack));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(OfflinePackFailure('An error occurred. Please try again.'));
    }
  }
}
