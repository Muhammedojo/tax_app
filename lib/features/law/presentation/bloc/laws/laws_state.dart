part of 'laws_cubit.dart';

sealed class LawsState extends Equatable {
  const LawsState();

  @override
  List<Object> get props => [];
}

class LawsLoading extends LawsState {}

class LawsLoaded extends LawsState {
  final List<Law> lawList;

  const LawsLoaded(this.lawList);

  @override
  List<Object> get props => [lawList];

  @override
  String toString() => 'LawsLoaded { Laws: $lawList }';
}

class LawsNotLoaded extends LawsState {}

class LawsFailure extends LawsState {
  final String error;

  const LawsFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LawsFailure { error: $error }';
}
