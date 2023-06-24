// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/core/error/failure.dart';
import 'package:blog_web/core/utils/classes/creds.dart';
import 'package:blog_web/domain/repository/abstract.dart';
import 'package:dartz/dartz.dart';

class Login {
  final Repository repo;
  Login({required this.repo});
  Future<Either<Failure, void>> call(DTOsCredential creds) async {
    return await repo.login(creds);
  }
}
