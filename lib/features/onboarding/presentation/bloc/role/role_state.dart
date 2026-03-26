part of 'role_cubit.dart';

sealed class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

class RoleLoading extends RoleState {}

class RoleLoaded extends RoleState {
  final List<Role> roleList;

  const RoleLoaded(this.roleList);

  @override
  List<Object> get props => [roleList];

  @override
  String toString() => 'RoleLoaded { Role: $roleList }';
}

class RoleNotLoaded extends RoleState {}

class RoleFailure extends RoleState {
  final String error;

  const RoleFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RoleFailure { error: $error }';
}
