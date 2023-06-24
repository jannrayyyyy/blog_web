import 'package:blog_web/presentation/auth/login.screen.dart';
import 'package:blog_web/presentation/screens/main.screen.dart';
import 'package:blog_web/presentation/statemanagement/cubit/auth/userchanges/userchange_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserchangeCubit, UserchangeState>(
      builder: (context, state) {
        if (state is UserchangeLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is UserchangeLoaded) {
          return const MainScreen();
        } else if (state is UserchangeEmpty) {
          return const LoginScreen();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
