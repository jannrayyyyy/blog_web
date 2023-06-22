import '../../../repository/abstract.dart';

class GetDownloadUrl {
  final Repository repo;
  GetDownloadUrl({
    required this.repo,
  });

  Future<String> call(String label, String path) async {
    return await repo.getDownloadUrl(label, path);
  }
}
