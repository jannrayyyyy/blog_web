import 'package:blog_web/presentation/widgets/components/desktop.view.dart';
import 'package:blog_web/presentation/widgets/components/mobile.view.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          'Blog-Web',
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        centerTitle: true,
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
