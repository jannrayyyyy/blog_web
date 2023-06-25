// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_web/domain/entities/cuisine.entity.dart';
import 'package:blog_web/domain/repository/abstract.dart';

class StreamCuisines {
  final Repository repo;
  StreamCuisines({required this.repo});
  Stream<List<CuisineEntity>> call() {
    return repo.streamCuisines();
  }
}
