part of 'stream_cuisines_cubit.dart';

abstract class StreamCuisinesState extends Equatable {
  const StreamCuisinesState();

  @override
  List<Object> get props => [];
}

class StreamCuisinesInitial extends StreamCuisinesState {}

class StreamCuisinesLoading extends StreamCuisinesState {}

class StreamCuisinesLoaded extends StreamCuisinesState {
  final List<CuisineEntity> cuisines;
  const StreamCuisinesLoaded({required this.cuisines});
}

class StreamCuisinesEmpty extends StreamCuisinesState {}
