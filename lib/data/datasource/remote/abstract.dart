import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utils/classes/creds.dart';
import '../../models/cuisine.model.dart';
import 'package:image_picker/image_picker.dart';

abstract class RemoteDatasource {
  Future<void> addCuisine(CuisineModel cuisine, String imageUrl);
  Future<void> uploadImageToStorage(
    String label,
    XFile? file,
  );
  Future<String> getDownloadUrl(String label, String path);
  Future<void> login(DTOsCredential creds);
  Stream<User?> streamUser();
}
