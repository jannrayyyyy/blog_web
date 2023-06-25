// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String password;
  final String createdAt;
  const UserEntity({
    required this.uid,
    required this.email,
    required this.password,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [];
}
