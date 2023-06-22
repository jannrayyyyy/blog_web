import 'package:bloc/bloc.dart';
import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:blog_web/domain/usecases/crud/create/add.cuisine.dart';
import 'package:blog_web/domain/usecases/crud/create/upload.to.storage.dart';
import 'package:blog_web/domain/usecases/crud/read/get.download.url.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  final GetDownloadUrl _getDownloadUrl;
  final UploadImageToStorage _uploadImageToStorage;
  final AddCuisine _addCuisine;
  StorageCubit(
    this._getDownloadUrl,
    this._uploadImageToStorage,
    this._addCuisine,
  ) : super(StorageInitial());

  Future<void> addCuisine(
    String label,
    XFile file,
    CuisineEntity cuisine,
  ) async {
    emit(StorageLoading());
    await _uploadImageToStorage(label, file).then(
      (value) async =>
          await _addCuisine(cuisine, await _getDownloadUrl(label, file.name))
              .then((value) => emit(const StorageSuccessful())),
    );
  }
}
