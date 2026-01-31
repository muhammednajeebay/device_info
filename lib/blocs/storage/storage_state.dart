part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageInitial extends StorageState {}

class StorageLoading extends StorageState {}

class StorageLoaded extends StorageState {
  final StorageInfo storageInfo;

  const StorageLoaded(this.storageInfo);

  @override
  List<Object> get props => [storageInfo];
}

class StorageError extends StorageState {
  final String message;

  const StorageError(this.message);

  @override
  List<Object> get props => [message];
}
