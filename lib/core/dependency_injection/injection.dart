import 'dart:io';

import 'package:employee_app/feature/module_global/presentation/bloc/language/language_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../feature/module_home/data/model/note_model.dart';
import '../../feature/module_location/data/data_source/user_location_data_source.dart';
import '../../feature/module_location/data/data_source/user_location_data_source_impl.dart';
import '../../feature/module_location/data/repository/user_location_repository_impl.dart';
import '../../feature/module_location/domain/repository/user_location_repository.dart';
import '../../feature/module_location/domain/use_case/get_user_location_use_case.dart';
import '../../feature/module_location/presentation/presentation/location_bloc.dart';

final getIt = GetIt.instance;

Future<void> dependencyInitialize() async {
  // ------------------------------ DATABASE ------------------------------
  final Directory appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(NoteModelAdapter());

  final noteBox = await Hive.openBox('note_box');
  getIt.registerLazySingleton<Box<dynamic>>(() => noteBox, instanceName: 'NoteBox');

  // ------------------------------ DATA SOURCE -----------------------------------
  getIt.registerLazySingleton<UserLocationDataSource>(() => UserLocationDataSourceImpl());

  // ------------------------------ REPOSITORY ------------------------------------
  getIt.registerLazySingleton<UserLocationRepository>(() => UserLocationRepositoryImpl(getIt()));

  // ------------------------------ USE CASE --------------------------------------
  getIt.registerFactory(() => GetUserLocationUseCase(getIt()));

  // ------------------------------ BLOC ------------------------------------------
  getIt.registerFactory<LocationBloc>(() => LocationBloc(getUserLocationUseCase: getIt<GetUserLocationUseCase>()));
  getIt.registerLazySingleton<LanguageBloc>(() => LanguageBloc());
}
