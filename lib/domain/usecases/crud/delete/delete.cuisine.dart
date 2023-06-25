// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/domain/repository/abstract.dart';

class DeleteCuisine {
  final Repository repo;
  DeleteCuisine({required this.repo});
  Future<void> call(String uid) async {
    await repo.deleteCuisine(uid);
  }
}
