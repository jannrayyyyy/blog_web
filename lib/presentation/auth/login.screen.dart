import 'package:blog_web/core/utils/classes/creds.dart';
import 'package:blog_web/presentation/statemanagement/cubit/auth/authentication/authentication_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/common/single.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../widgets/customs/new.textformfield.dart';
import '../widgets/customs/text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  VideoPlayerController? _videoPlayerController;
  // ignore: unused_field
  Future<void>? _initializeVideoPlayerFuture;
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/vid-bg.mp4');
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
    _videoPlayerController!.setLooping(true);
    _videoPlayerController!.setVolume(0.0);
    _videoPlayerController!.play();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final isObscure = context.select((ObscureCubit bloc) => bloc.state);
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20.h),
            CustomText(
              'Food Blog',
              size: 30,
              color: Theme.of(context).primaryColor,
              weight: FontWeight.bold,
            ),
            CustomText(
              'Admin Authentication',
              size: 22,
              color: Theme.of(context).primaryColor,
              weight: FontWeight.w500,
            ),
            SizedBox(height: 2.h),
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: _videoPlayerController!.value
                          .copyWith(
                            size: const Size(400, 228),
                          )
                          .size
                          .height,
                      width: _videoPlayerController!.value
                          .copyWith(
                            size: const Size(400, 228),
                          )
                          .size
                          .width,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(2.h),
                        height: 228,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 4.h),
                            NewTextformfield(
                              hint: 'Email',
                              controller: email,
                            ),
                            SizedBox(height: 2.h),
                            NewTextformfield(
                              hint: 'Password',
                              controller: password,
                              maxLines: 1,
                              isObscure: isObscure,
                              suffix: IconButton(
                                onPressed: () {
                                  context
                                      .read<ObscureCubit>()
                                      .onChanged(!isObscure);
                                },
                                icon: isObscure
                                    ? const Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthenticationCubit>().login(
                        DTOsCredential(
                          email: email.text,
                          password: password.text,
                        ),
                      );
                }
              },
              child: const CustomText('Login'),
            ),
            BlocListener<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
                if (state is Loading) {
                  showDialog(
                    context: context,
                    builder: (ctx) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is Loaded) {
                  Navigator.pop(context);
                } else if (state is Error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: CustomText(
                        state.message,
                        color: Colors.white,
                      ),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Container(),
            )
          ],
        ),
      );
    });
  }
}
