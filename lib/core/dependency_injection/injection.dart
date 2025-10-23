import 'package:employee_app/feature/module_global/presentation/bloc/language/language_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../feature/module_location/data/data_source/user_location_data_source.dart';
import '../../feature/module_location/data/data_source/user_location_data_source_impl.dart';
import '../../feature/module_location/data/repository/user_location_repository_impl.dart';
import '../../feature/module_location/domain/repository/user_location_repository.dart';
import '../../feature/module_location/domain/use_case/get_user_location_use_case.dart';
import '../../feature/module_location/presentation/presentation/location_bloc.dart';

final getIt = GetIt.instance;

void dependencyInitialize() {
  // ------------------------------ DATA SOURCE -----------------------------------
  getIt.registerLazySingleton<UserLocationDataSource>(() => UserLocationDataSourceImpl());

  // ------------------------------ REPOSITORY ------------------------------------
  getIt.registerLazySingleton<UserLocationRepository>(() => UserLocationRepositoryImpl(getIt()));

  // ------------------------------ USE CASE --------------------------------------
  getIt.registerFactory(() => GetUserLocationUseCase(getIt()));

  // ------------------------------ BLOC ------------------------------------------
  getIt.registerFactory<LocationBloc>(
    () => LocationBloc(getUserLocationUseCase: getIt<GetUserLocationUseCase>()),
  );

  getIt.registerLazySingleton<LanguageBloc>(() => LanguageBloc());
}
