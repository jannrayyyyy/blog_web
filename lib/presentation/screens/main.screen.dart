import 'package:blog_web/presentation/extensions/cuisines.screen.dart';
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/stream_cuisine/stream_cuisines_cubit.dart';
import 'package:blog_web/presentation/widgets/components/desktop.view.dart';
import 'package:blog_web/presentation/widgets/components/mobile.view.dart';
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
              child: Row(
                children: [
                  Icon(
                    Icons.breakfast_dining,
                    color: isCuisineHovered
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
                  SizedBox(width: 0.2.w),
                  CustomText(
                    'Cuisines',
                    size: 12,
                    color: isCuisineHovered
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
                ],
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
