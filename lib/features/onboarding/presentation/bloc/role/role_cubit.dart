import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/role.dart';

part 'role_state.dart';

class RoleCubit extends Cubit<RoleState> {
  final IAppRepository repository;
  RoleCubit({required this.repository}) : super(RoleLoading());

  Future<void> loadRolesFromServer() async {
    try {
      emit(RoleLoading());
      final response = await repository.getRoleList();
      response.fold(
        (l) {
          debugPrint("Role Loading Failure: ${l.failureMessage()}");
          emit(RoleFailure(l.failureMessage()));
        },
        (r) async {
          debugPrint("Role Loading Success: ${r.message}");

          emit(RoleLoaded(r.data!));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(RoleFailure('An error occurred. Please try again.'));
    }
  }
}
