part of 'cuisine_cubit.dart';

abstract class CuisineState extends Equatable {
  const CuisineState();

  @override
  List<Object> get props => [];
}

class CuisineInitial extends CuisineState {}

class CuisineLoading extends CuisineState {}

class CuisineLoaded extends CuisineState {}

class CuisineEmpty extends CuisineState {}

class CuisineAddedSuccessfully extends CuisineState {}
