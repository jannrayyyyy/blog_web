import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../../../repository/abstract.dart';

class UploadImageToStorage {
  final Repository repo;
  UploadImageToStorage({
    required this.repo,
  });

  Future<Either<Failure, void>> call(
    String label,
    XFile? file,
  ) async {
    return await repo.uploadImageToStorage(label, file);
  }
}
