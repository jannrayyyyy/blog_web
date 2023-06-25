// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/core/utils/classes/creds.dart';
import 'package:blog_web/core/utils/constant/error.code.dart';
import 'package:blog_web/data/datasource/remote/abstract.dart';
import 'package:blog_web/data/models/cuisine.model.dart';
import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:blog_web/domain/repository/abstract.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/error/failure.dart';

class RepositoryImpl implements Repository {
  final RemoteDatasource remote;
  RepositoryImpl({required this.remote});

  @override
  Future<void> addCuisine(CuisineEntity cuisine, String imageUrl) async {
    await remote.addCuisine(CuisineModel.toEntity(cuisine), imageUrl);
  }

  @override
  Future<String> getDownloadUrl(String label, String path) async {
    return await remote.getDownloadUrl(label, path);
  }

  @override
  Future<Either<Failure, void>> uploadImageToStorage(
    String label,
    XFile? file,
  ) async {
    try {
      final result = await remote.uploadImageToStorage(
        label,
        file,
      );
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> login(DTOsCredential creds) async {
    try {
      await remote.login(creds);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      print(e);
      return Left(AuthenticationFailure(errorCode(e.code)));
    }
  }

  @override
  Stream<User?> streamUser() => remote.streamUser();

  @override
  Stream<List<CuisineEntity>> streamCuisines() {
    return remote.streamCuisines();
  }

  @override
  Future<void> deleteCuisine(String uid) async {
    await remote.deleteCuisine(uid);
  }

  @override
  Future<void> updateCuisine(String uid, CuisineEntity cuisine) async {
    await remote.updateCuisine(uid, CuisineModel.toEntity(cuisine));
  }
}
