import 'package:blog_web/domain/usecases/crud/create/add.cuisine.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cuisine_state.dart';

class CuisineCubit extends Cubit<CuisineState> {
  final AddCuisine _addCuisine;
  CuisineCubit(this._addCuisine) : super(CuisineInitial());
}
