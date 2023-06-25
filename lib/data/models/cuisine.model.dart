import 'package:blog_web/domain/entities/cuisine.entity.dart';

// ignore: must_be_immutable
class CuisineModel extends CuisineEntity {
  CuisineModel({
    super.uid,
    super.image,
    required super.title,
    required super.desc,
    required super.isFavorite,
    required super.procedures,
    required super.ingredients,
    required super.notes,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      uid: json['uid'],
      image: json['image'],
      title: json['title'],
      desc: json['desc'],
      isFavorite: json['isFavorite'],
      procedures: json['procedures'],
      ingredients: json['ingredients'],
      notes: json['notes'],
    );
  }

  factory CuisineModel.toEntity(CuisineEntity cuisine) {
    return CuisineModel(
      uid: cuisine.uid,
      title: cuisine.title,
      desc: cuisine.desc,
      image: cuisine.image ?? '',
      isFavorite: cuisine.isFavorite,
      procedures: cuisine.procedures,
      ingredients: cuisine.ingredients,
      notes: cuisine.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'desc': desc,
      'image': image ?? '',
      'isFavorite': isFavorite,
      'procedures': procedures,
      'ingredients': ingredients,
      'notes': notes,
    };
  }
}
