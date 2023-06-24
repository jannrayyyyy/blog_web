// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'userchange_cubit.dart';

abstract class UserchangeState extends Equatable {
  const UserchangeState();

  @override
  List<Object> get props => [];
}

class UserchangeInitial extends UserchangeState {}

class UserchangeLoading extends UserchangeState {}

class UserchangeLoaded extends UserchangeState {
  final User user;
  const UserchangeLoaded({required this.user});
}

class UserchangeEmpty extends UserchangeState {}
