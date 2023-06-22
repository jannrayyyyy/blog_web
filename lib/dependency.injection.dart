import 'package:blog_web/data/datasource/remote/abstract.dart';
import 'package:blog_web/data/datasource/remote/implementation.dart';
import 'package:blog_web/data/repository/implementation.dart';
import 'package:blog_web/domain/repository/abstract.dart';
import 'package:blog_web/domain/usecases/crud/create/add.cuisine.dart';
import 'package:blog_web/domain/usecases/crud/create/upload.to.storage.dart';
import 'package:blog_web/domain/usecases/crud/read/get.download.url.dart';
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/cuisine_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/storage/storage_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(() => CuisineCubit(sl()));
  sl.registerFactory(() => StorageCubit(sl(), sl(), sl()));

  sl.registerLazySingleton(() => AddCuisine(repo: sl()));
  sl.registerLazySingleton(() => UploadImageToStorage(repo: sl()));
  sl.registerLazySingleton(() => GetDownloadUrl(repo: sl()));

  sl.registerLazySingleton<Repository>(() => RepositoryImpl(remote: sl()));
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl());
}
