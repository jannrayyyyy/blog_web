// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Loading extends AuthenticationState {}

class Loaded extends AuthenticationState {}

class Error extends AuthenticationState {
  final String message;
  const Error({
    required this.message,
  });
}
