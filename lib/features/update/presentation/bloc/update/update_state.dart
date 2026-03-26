part of 'update_cubit.dart';

sealed class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateLoading extends UpdateState {}

class UpdateLoaded extends UpdateState {
  final List<Update> updateList;

  const UpdateLoaded(this.updateList);

  @override
  List<Object> get props => [updateList];

  @override
  String toString() => 'UpdateLoaded { Updates: $updateList }';
}

class UpdateNotLoaded extends UpdateState {}

class UpdateFailure extends UpdateState {
  final String error;

  const UpdateFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateFailure { error: $error }';
}
