import 'package:blog_web/data/datasource/remote/abstract.dart';
import 'package:blog_web/data/datasource/remote/implementation.dart';
import 'package:blog_web/data/repository/implementation.dart';
import 'package:blog_web/domain/repository/abstract.dart';
import 'package:blog_web/domain/usecases/auth/login.dart';
import 'package:blog_web/domain/usecases/auth/stream.user.dart';
import 'package:blog_web/domain/usecases/crud/create/add.cuisine.dart';
import 'package:blog_web/domain/usecases/crud/create/upload.to.storage.dart';
import 'package:blog_web/domain/usecases/crud/delete/delete.cuisine.dart';
import 'package:blog_web/domain/usecases/crud/read/get.download.url.dart';
import 'package:blog_web/domain/usecases/crud/read/stream.cuisines.dart';
import 'package:blog_web/domain/usecases/crud/update/update.cuisine.dart';
import 'package:blog_web/presentation/statemanagement/cubit/auth/authentication/authentication_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/auth/userchanges/userchange_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/cuisine_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/cuisine/stream_cuisine/stream_cuisines_cubit.dart';
import 'package:blog_web/presentation/statemanagement/cubit/storage/storage_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(() => StreamCuisinesCubit(sl()));
  sl.registerFactory(() => CuisineCubit(sl(), sl()));
  sl.registerFactory(() => StorageCubit(sl(), sl(), sl()));
  sl.registerFactory(() => UserchangeCubit(sl()));
  sl.registerFactory(() => AuthenticationCubit(sl()));

  sl.registerLazySingleton(() => AddCuisine(repo: sl()));
  sl.registerLazySingleton(() => UploadImageToStorage(repo: sl()));
  sl.registerLazySingleton(() => GetDownloadUrl(repo: sl()));
  sl.registerLazySingleton(() => StreamUser(repo: sl()));
  sl.registerLazySingleton(() => Login(repo: sl()));
  sl.registerLazySingleton(() => StreamCuisines(repo: sl()));
  sl.registerLazySingleton(() => DeleteCuisine(repo: sl()));
  sl.registerLazySingleton(() => UpdateCuisine(repo: sl()));

  sl.registerLazySingleton<Repository>(() => RepositoryImpl(remote: sl()));
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl());
}
