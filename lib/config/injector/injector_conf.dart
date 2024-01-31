import 'package:get_it/get_it.dart';
import 'package:mb_hero_post/data/data_sources/printer_data_source.dart';
import 'package:mb_hero_post/data/repositories/printer_repository_impl.dart';
import 'package:mb_hero_post/domain/repositories/printer_repository.dart';
import 'package:mb_hero_post/domain/usecase/bluetooth_status.dart';
import 'package:mb_hero_post/domain/usecase/delete_produk.dart';
import 'package:mb_hero_post/domain/usecase/get_bluetooth_info.dart';
import 'package:mb_hero_post/domain/usecase/get_image_from_galery.dart';
import 'package:mb_hero_post/domain/usecase/get_paired_bluetooth_printer.dart';
import 'package:mb_hero_post/domain/usecase/get_produk.dart';
import 'package:mb_hero_post/domain/usecase/get_profile.dart';
import 'package:mb_hero_post/domain/usecase/insert_produk.dart';
import 'package:mb_hero_post/domain/usecase/print_struk.dart';
import 'package:mb_hero_post/domain/usecase/save_bluetooth_Info.dart';
import 'package:mb_hero_post/domain/usecase/update_produk.dart';
import 'package:mb_hero_post/domain/usecase/update_profile.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_info_cubit/bluetooth_info_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_status_cubit/bluetooth_status_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_cubit/printer_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_paired_cubit/printer_paired_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/produk_cubit/produk_cubit.dart';
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
  getIt.registerFactory(
    () => PrinterPairedCubit(
      getPairedBluetooth: getIt.get<GetPairedBluetoothPrinterUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => BluetoothStatusCubit(
      bluetoothStatus: getIt.get<BluetoothStatusUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => ProdukCubit(
      getProdukUseCase: getIt.get<GetProdukUseCase>(),
      insertProdukUseCase: getIt.get<InsertProdukUseCase>(),
      updateProdukUseCase: getIt.get<UpdateProdukUseCase>(),
      deleteProdukUseCase: getIt.get<DeleteProdukUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => PrinterCubit(
      printStruk: getIt.get<PrintStrukUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => BluetoothInfoCubit(
      getBluetoothInfo: getIt.get<GetBluetoothInfoUseCase>(),
      saveBluetoothInfo: getIt.get<SaveBluetoothInfoUseCase>(),
    ),
  );

  /**
   * data_source
   */
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<PrinterDataSource>(
    () => PrinterDataSourceImpl(),
  );

  /**
   * repository
   */
  getIt.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(localDataSource: getIt.get<LocalDataSource>()),
  );
  getIt.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(
        printerDataSource: getIt.get<PrinterDataSource>()),
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
  getIt.registerLazySingleton<PrintStrukUseCase>(
    () => PrintStrukUseCase(
      printRepository: getIt.get<PrinterRepository>(),
    ),
  );
  getIt.registerLazySingleton<BluetoothStatusUseCase>(
    () => BluetoothStatusUseCase(
      printRepository: getIt.get<PrinterRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetPairedBluetoothPrinterUseCase>(
    () => GetPairedBluetoothPrinterUseCase(
      printRepository: getIt.get<PrinterRepository>(),
    ),
  );
  getIt.registerLazySingleton<InsertProdukUseCase>(
    () => InsertProdukUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetProdukUseCase>(
    () => GetProdukUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<DeleteProdukUseCase>(
    () => DeleteProdukUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<UpdateProdukUseCase>(
    () => UpdateProdukUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetBluetoothInfoUseCase>(
    () => GetBluetoothInfoUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
  getIt.registerLazySingleton<SaveBluetoothInfoUseCase>(
    () => SaveBluetoothInfoUseCase(
      localRepository: getIt.get<LocalRepository>(),
    ),
  );
}
