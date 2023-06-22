import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/error/failure.dart';

abstract class Repository {
  Future<void> addCuisine(CuisineEntity cuisine, String imageUrl);
  Future<Either<Failure, void>> uploadImageToStorage(
    String label,
    XFile? file,
  );
  Future<String> getDownloadUrl(String label, String path);
}