import 'package:blog_web/presentation/statemanagement/cubit/cuisine/cuisine_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../dependency.injection.dart';
import '../../../domain/entities/cuisine.entity.dart';
import '../../extensions/food.info.screen.dart';
import '../customs/text.dart';

class BlogContainer extends StatelessWidget {
  final CuisineEntity food;
  const BlogContainer({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              food.image ?? '',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                food.title,
                weight: FontWeight.bold,
                size: 13,
              ),
              CustomText(
                food.desc,
                size: 12,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                  create: (context) => sl<CuisineCubit>(),
                  child: FoodInfoScreen(
                    food: food,
                  ),
                ),
              ),
            ),
            child: const CustomText(
              'View More',
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
