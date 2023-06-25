// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:blog_web/domain/repository/abstract.dart';

class UpdateCuisine {
  final Repository repo;
  UpdateCuisine({required this.repo});
  Future<void> call(String uid, CuisineEntity cuisine) async {
    await repo.updateCuisine(uid, cuisine);
  }
}
