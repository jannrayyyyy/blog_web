import 'package:blog_web/domain/usecases/crud/delete/delete.cuisine.dart';
import 'package:blog_web/domain/usecases/crud/update/update.cuisine.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/cuisine.entity.dart';

part 'cuisine_state.dart';

class CuisineCubit extends Cubit<CuisineState> {
  final DeleteCuisine _deleteCuisine;
  final UpdateCuisine _updateCuisine;
  CuisineCubit(
    this._deleteCuisine,
    this._updateCuisine,
  ) : super(CuisineInitial());

  Future<void> deleteCuisine(String uid) async {
    emit(CuisineDeleting());
    await _deleteCuisine(uid);
    emit(CuisineDeletedSuccessfully());
  }

  Future<void> updateCuisine(String uid, CuisineEntity cuisine) async {
    emit(CuisineUpdating());
    await _updateCuisine(uid, cuisine);
    emit(CuisineUpdatedSuccessfully());
  }
}
