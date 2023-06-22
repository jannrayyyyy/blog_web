part of 'storage_cubit.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageInitial extends StorageState {}

class StorageLoading extends StorageState {}

class StorageSuccessful extends StorageState {
  final String? response;
  const StorageSuccessful({this.response});
}

class StorageError extends StorageState {
  final String msg;
  const StorageError({required this.msg});
}
