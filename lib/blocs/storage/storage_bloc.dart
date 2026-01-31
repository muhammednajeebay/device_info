import 'package:device_info/data/repositories/storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_info/data/models/storage_info.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final StorageRepository _repository;

  StorageBloc(this._repository) : super(StorageInitial()) {
    on<LoadStorageInfo>(_onLoadStorageInfo);
  }

  Future<void> _onLoadStorageInfo(
    LoadStorageInfo event,
    Emitter<StorageState> emit,
  ) async {
    emit(StorageLoading());
    try {
      final storageInfo = await _repository.getStorageInfo();
      emit(StorageLoaded(storageInfo));
    } catch (e) {
      emit(StorageError(e.toString()));
    }
  }
}
