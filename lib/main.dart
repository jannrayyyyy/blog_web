import 'package:blog_web/presentation/auth/auth.screen.dart';
import 'package:blog_web/presentation/statemanagement/cubit/auth/authentication/authentication_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/auth/userchanges/userchange_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/cuisine_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/image/image_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/storage/storage_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dependency.injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          title: 'Blog-Web',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<CuisineCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<StorageCubit>(),
              ),
              BlocProvider(
                create: (context) => ImageCubit(),
              ),
              BlocProvider(
                create: (context) => sl<AuthenticationCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<UserchangeCubit>()..streamUser(),
              ),
            ],
            child: const AuthScreen(),
          ),
        );
      },
    );
  }
}
