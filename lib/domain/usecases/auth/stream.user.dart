// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/domain/repository/abstract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreamUser {
  final Repository repo;
  StreamUser({required this.repo});
  Stream<User?> call() => repo.streamUser();
}
