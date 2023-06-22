// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CuisineEntity extends Equatable {
  String? uid;
  String? image;
  final String title;
  final String desc;

  final bool isFavorite;
  final List procedures;
  final List ingredients;
  final List notes;
  CuisineEntity({
    this.uid,
    this.image,
    required this.title,
    required this.desc,
    required this.isFavorite,
    required this.procedures,
    required this.ingredients,
    required this.notes,
  });

  @override
  List<Object?> get props => [title];
}
