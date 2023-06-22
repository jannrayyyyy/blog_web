// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:blog_web/domain/repository/abstract.dart';

class AddCuisine {
  final Repository repo;
  AddCuisine({required this.repo});
  Future<void> call(CuisineEntity cuisine, String imageUrl) async {
    await repo.addCuisine(cuisine, imageUrl);
  }
}
