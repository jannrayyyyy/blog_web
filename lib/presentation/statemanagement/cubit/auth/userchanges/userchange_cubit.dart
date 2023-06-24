import 'package:blog_web/domain/usecases/auth/stream.user.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'userchange_state.dart';

class UserchangeCubit extends Cubit<UserchangeState> {
  final StreamUser _streamUser;
  UserchangeCubit(this._streamUser) : super(UserchangeInitial());

  Future<void> streamUser() async {
    final user = _streamUser();
    user.listen((event) {
      if (event == null) {
        emit(UserchangeEmpty());
      } else {
        emit(UserchangeLoaded(user: event));
      }
    });
  }
}
