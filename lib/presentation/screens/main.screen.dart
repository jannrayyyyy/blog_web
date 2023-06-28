import 'package:blog_web/presentation/extensions/cuisines.screen.dart';
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/stream_cuisine/stream_cuisines_cubit.dart';
import 'package:blog_web/presentation/widgets/components/desktop.view.dart';
import 'package:blog_web/presentation/widgets/components/mobile.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../dependency.injection.dart';
import '../widgets/customs/text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<TextEditingController> ingredients = [];
  final List<TextEditingController> procedures = [];
  final List<TextEditingController> notes = [];
  bool isCuisineHovered = false;
  bool isLogoutHovered = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Lutong Pinoy',
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                  create: (context) =>
                      sl<StreamCuisinesCubit>()..streamCuisines(),
                  child: const CuisinesScreen(),
                ),
              ),
            ),
            child: MouseRegion(
              onHover: (event) {
                setState(() {
                  isCuisineHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isCuisineHovered = false;
                });
              },
              child: Icon(
                Icons.breakfast_dining,
                color: isCuisineHovered
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
          ),
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => Dialog(
                child: Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.all(2.h),
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        'Are you sure you want to logout this account?',
                        align: TextAlign.center,
                        weight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => FirebaseAuth.instance.signOut(),
                            child: const CustomText('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const CustomText('No'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            child: MouseRegion(
              onHover: (event) {
                setState(() {
                  isLogoutHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isLogoutHovered = false;
                });
              },
              child: Icon(
                Icons.logout,
                color: isLogoutHovered
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: screenSize < 1300
          ? MobileView(
              screenSize: screenSize,
              ingredients: ingredients,
              procedures: procedures,
              notes: notes,
            )
          : DesktopView(
              screenSize: screenSize,
              ingredients: ingredients,
              procedures: procedures,
              notes: notes,
            ),
    );
  }
}
