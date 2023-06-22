import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:blog_web/presentation/statemanagement/cubit/storage/storage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../statemanagement/cubit/image/image_cubit.dart';
import '../customs/text.dart';
import '../customs/textfield.dart';
import '../growable.textfield.dart';

class MobileView extends StatefulWidget {
  final double screenSize;
  final List<TextEditingController> ingredients;
  final List<TextEditingController> procedures;
  final List<TextEditingController> notes;
  const MobileView({
    super.key,
    required this.screenSize,
    required this.ingredients,
    required this.procedures,
    required this.notes,
  });

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void clearAll() {
    title.clear();
    desc.clear();
    for (var controller in widget.ingredients) {
      controller.clear();
    }
    for (var controller in widget.procedures) {
      controller.clear();
    }
    for (var controller in widget.notes) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final image = context.select(
        (ImageCubit image) => image.state.image,
      );
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: widget.screenSize < 600 ? 2.h : 12.w, vertical: 2.h),
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hint: 'Food Name',
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                CustomTextField(
                  hint: 'Food Description',
                  controller: desc,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                const CustomText('Image'),
                Container(
                  height: 40.h,
                  margin: EdgeInsets.all(1.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      image != null
                          ? Opacity(
                              opacity: 0.7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  image.path,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Positioned(
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                context
                                    .read<ImageCubit>()
                                    .pickImage(ImageSource.gallery);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                GrowableTextField(
                  label: 'Ingredients',
                  hint: 'Food ingridients',
                  controllers: widget.ingredients,
                ),
                GrowableTextField(
                  label: 'Procedures',
                  hint: 'Food procedure',
                  controllers: widget.procedures,
                ),
                GrowableTextField(
                  label: 'Notes',
                  hint: 'Food note',
                  controllers: widget.notes,
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      final cuisine = CuisineEntity(
                        title: title.text,
                        desc: desc.text,
                        isFavorite: false,
                        procedures:
                            widget.procedures.map((e) => e.text).toList(),
                        ingredients:
                            widget.ingredients.map((e) => e.text).toList(),
                        notes: widget.notes.map((e) => e.text).toList(),
                      );
                      if (formKey.currentState!.validate() &&
                          widget.procedures.isNotEmpty &&
                          widget.ingredients.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (ctx) => Dialog(
                            child: Container(
                              height: 200,
                              width: 200,
                              padding: EdgeInsets.all(2.h),
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    'Are you sure you want to add this cuisine in your list?',
                                    align: TextAlign.center,
                                    weight: FontWeight.bold,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<StorageCubit>()
                                              .addCuisine(
                                                cuisine.title,
                                                image ?? XFile(''),
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
                      }
                    },
                    child: const CustomText('Add Cuisine'),
                  ),
                ),
                BlocListener<StorageCubit, StorageState>(
                  listener: (context, state) {
                    if (state is StorageLoading) {
                      showDialog(
                        context: context,
                        builder: (ctx) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is StorageSuccessful) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context.read<ImageCubit>().clearImage();

                      clearAll();
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
