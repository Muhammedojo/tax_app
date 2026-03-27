part of 'offline_pack_cubit.dart';

sealed class OfflinePackState extends Equatable {
  const OfflinePackState();

  @override
  List<Object> get props => [];
}

class OfflinePackLoading extends OfflinePackState {}

class OfflinePackLoaded extends OfflinePackState {
  final OfflinePack offlinePack;

  const OfflinePackLoaded(this.offlinePack);

  @override
  List<Object> get props => [offlinePack];

  @override
  String toString() => 'OfflinePackLoaded { OfflinePack: $offlinePack }';
}

class OfflinePackInitial extends OfflinePackState {}

class OfflinePackNotLoaded extends OfflinePackState {}

class OfflinePackFailure extends OfflinePackState {
  final String error;

  const OfflinePackFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OfflinePackFailure { error: $error }';
}
