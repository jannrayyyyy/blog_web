// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/cuisine_cubit.dart';
import 'package:blog_web/presentation/widgets/customs/new.textformfield.dart';
import 'package:blog_web/presentation/widgets/growable.textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../domain/entities/cuisine.entity.dart';
import '../widgets/customs/text.dart';

class FoodInfoScreen extends StatefulWidget {
  final CuisineEntity food;
  const FoodInfoScreen({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<FoodInfoScreen> createState() => _FoodInfoScreenState();
}

class _FoodInfoScreenState extends State<FoodInfoScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final List<TextEditingController> ingredients = [];
  final List<TextEditingController> procedures = [];
  final List<TextEditingController> notes = [];

  @override
  void initState() {
    title.text = widget.food.title;
    desc.text = widget.food.desc;

    procedures.addAll(
      widget.food.procedures.map((e) => TextEditingController(text: e)),
    );
    ingredients.addAll(
      widget.food.ingredients.map((e) => TextEditingController(text: e)),
    );
    notes.addAll(
      widget.food.notes.map((e) => TextEditingController(text: e)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Food Information',
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.update,
              color: Colors.green,
            ),
            onPressed: () {
              final cuisine = CuisineEntity(
                uid: widget.food.uid,
                image: widget.food.image,
                title: title.text,
                desc: desc.text,
                isFavorite: false,
                procedures: procedures.map((e) => e.text).toList(),
                ingredients: ingredients.map((e) => e.text).toList(),
                notes: notes.map((e) => e.text).toList(),
              );
              showDialog(
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
                          'Are you sure you want to update this cuisine in your list?',
                          align: TextAlign.center,
                          weight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<CuisineCubit>().updateCuisine(
                                      widget.food.uid ?? '',
                                      cuisine,
                                    );
                              },
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
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
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
                          'Are you sure you want to delete this cuisine in your list?',
                          align: TextAlign.center,
                          weight: FontWeight.bold,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<CuisineCubit>()
                                    .deleteCuisine(widget.food.uid ?? '');
                              },
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
              );
            },
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.food.image ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(),
              NewTextformfield(
                hint: 'Food name',
                controller: title,
                color: Colors.black,
              ),
              SizedBox(height: 2.h),
              NewTextformfield(
                hint: 'Food description',
                controller: desc,
                color: Colors.black,
                maxLines: 15,
              ),
              const SizedBox(height: 12),
              GrowableTextField(
                controllers: ingredients,
                label: 'Ingredients',
                hint: 'Ingredients',
                maxLines: 1,
              ),
              const SizedBox(height: 12),
              GrowableTextField(
                controllers: procedures,
                label: 'Procedures',
                hint: 'Procedures',
                maxLines: 1,
              ),
              const SizedBox(height: 12),
              widget.food.notes.isEmpty
                  ? const SizedBox()
                  : const CustomText(
                      'Notes',
                      weight: FontWeight.bold,
                    ),
              widget.food.notes.isEmpty
                  ? const SizedBox()
                  : GrowableTextField(
                      controllers: notes,
                      label: 'Notes',
                      hint: 'Notes',
                      maxLines: 1,
                    ),
              BlocListener<CuisineCubit, CuisineState>(
                listener: (context, state) {
                  if (state is CuisineDeleting || state is CuisineUpdating) {
                    showDialog(
                      context: context,
                      builder: (ctx) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is CuisineDeletedSuccessfully) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else if (state is CuisineUpdatedSuccessfully) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
