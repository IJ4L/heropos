import 'package:get_it/get_it.dart';
import 'package:mb_hero_post/domain/usecase/get_image_from_galery.dart';
import 'package:mb_hero_post/domain/usecase/get_profile.dart';
import 'package:mb_hero_post/domain/usecase/update_profile.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'injector.dart';

final getIt = GetIt.instance;

void configureDepedencies() async {
  getIt.registerFactory<AppRouteConf>(
    () => AppRouteConf(),
  );

  /**
   * cubit
   */
  getIt.registerFactory(() => ListCardCubit());
  getIt.registerFactory(() => PembayaranCubit());
  getIt.registerFactory(() => TroliCubit());
  getIt.registerFactory(
    () => TransactionCubit(
      insertTransaction: getIt.get<InsertTransactionUseCase>(),
      insertTransactionDetail: getIt.get<InsertTransactionDetailUseCase>(),
      getTransactionDetail: getIt.get<GetTransactionDetailUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => ProfileCubit(
      getProfile: getIt.get<GetProfileUseCase>(),
      updateProfile: getIt.get<UpdateProfileUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => CamereCubit(
      getImageFromGalery: getIt.get<GetImageFromGaleryUseCase>(),
    ),
  );

  /**
   * data_source
   */
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  /**
   * repository
   */
  getIt.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(localDataSource: getIt.get<LocalDataSource>()),
  );

  /**
   * usecase
   */
  getIt.registerLazySingleton<InsertTransactionUseCase>(
    () => InsertTransactionUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<InsertTransactionDetailUseCase>(
    () => InsertTransactionDetailUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetTransactionDetailUseCase>(
    () => GetTransactionDetailUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetImageFromGaleryUseCase>(
    () => GetImageFromGaleryUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
}
