// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class CuisineDeleting extends CuisineState {}

class CuisineDeletedSuccessfully extends CuisineState {}

class CuisineUpdating extends CuisineState {}

class CuisineUpdatedSuccessfully extends CuisineState {}
