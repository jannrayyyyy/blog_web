// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:blog_web/core/utils/classes/creds.dart';
import 'package:equatable/equatable.dart';

import 'package:blog_web/domain/usecases/auth/login.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final Login _login;
  AuthenticationCubit(
    this._login,
  ) : super(AuthenticationInitial());

  Future<void> login(DTOsCredential creds) async {
    emit(Loading());
    final state = await _login(creds);
    state.fold((l) => emit(Error(message: l.message)), (r) => emit(Loaded()));
  }
}
