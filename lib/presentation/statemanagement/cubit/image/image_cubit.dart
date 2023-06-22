import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<WebInitial> {
  ImageCubit() : super(WebInitial(image: null));

  void pickImage(ImageSource source) async {
    final imagePicked =
        await ImagePicker().pickImage(source: source).then((value) {
      return value;
    });

    if (imagePicked == null) {
      return;
    } else {
      emit(WebInitial(image: imagePicked));
    }
  }

  void clearImage() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        emit(WebInitial(image: null));
      },
    );
  }
}
