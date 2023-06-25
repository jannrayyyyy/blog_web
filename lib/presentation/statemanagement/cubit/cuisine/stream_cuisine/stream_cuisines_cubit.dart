import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/cuisine.entity.dart';
import '../../../../../domain/usecases/crud/read/stream.cuisines.dart';

part 'stream_cuisines_state.dart';

class StreamCuisinesCubit extends Cubit<StreamCuisinesState> {
  final StreamCuisines _streamCuisines;
  StreamCuisinesCubit(this._streamCuisines) : super(StreamCuisinesInitial());
  Future<void> streamCuisines() async {
    emit(StreamCuisinesLoading());
    final cuisines = _streamCuisines();
    cuisines.listen((event) {
      if (event.isEmpty) {
        emit(StreamCuisinesEmpty());
      } else {
        emit(StreamCuisinesLoading());
        emit(StreamCuisinesLoaded(cuisines: event));
      }
    });
  }
}
