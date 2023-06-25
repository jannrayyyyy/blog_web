import 'package:blog_web/presentation/statemanagement/cubit/cuisine/stream_cuisine/stream_cuisines_cubit.dart';
import 'package:blog_web/presentation/widgets/components/blog.container.dart';
import 'package:blog_web/presentation/widgets/customs/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CuisinesScreen extends StatelessWidget {
  const CuisinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Cuisines',
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: screenSize < 700
              ? 4.h
              : screenSize < 1200
                  ? 30.h
                  : 60.h,
        ),
        child: BlocBuilder<StreamCuisinesCubit, StreamCuisinesState>(
          builder: (context, state) {
            if (state is StreamCuisinesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StreamCuisinesLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: state.cuisines
                      .map((e) => BlogContainer(food: e))
                      .toList(),
                ),
              );
            } else if (state is StreamCuisinesEmpty) {
              return const Center(
                child: CustomText(
                  'No available cuisines at the moment!',
                  weight: FontWeight.bold,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
