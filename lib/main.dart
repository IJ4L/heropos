import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/config/injector/injector_conf.dart' as di;
import 'package:mb_hero_post/config/schema/color_schema.dart';
import 'package:mb_hero_post/core/routes/app_route_conf.dart';
import 'package:mb_hero_post/data/data_sources/local_data_source.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_info_cubit/bluetooth_info_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_status_cubit/bluetooth_status_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/calender_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/data_home_cubit/data_home_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/list_card_cubit/list_card_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/pembayaran_cubit/pembayaran_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_cubit/printer_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_paired_cubit/printer_paired_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/produk_cubit/produk_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  di.configureDepedencies();
  await LocalDataSourceImpl().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = di.getIt<AppRouteConf>().router;
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(360, 690),
      rebuildFactor: RebuildFactors.always,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.getIt<ListCardCubit>()),
            BlocProvider(create: (_) => di.getIt<TroliCubit>()),
            BlocProvider(create: (_) => di.getIt<PembayaranCubit>()),
            BlocProvider(create: (_) => di.getIt<TransactionCubit>()),
            BlocProvider(create: (_) => di.getIt<ProfileCubit>()),
            BlocProvider(create: (_) => di.getIt<CamereCubit>()),
            BlocProvider(create: (_) => di.getIt<PrinterPairedCubit>()),
            BlocProvider(create: (_) => di.getIt<PrinterCubit>()),
            BlocProvider(create: (_) => di.getIt<BluetoothStatusCubit>()),
            BlocProvider(create: (_) => di.getIt<ProdukCubit>()),
            BlocProvider(create: (_) => di.getIt<BluetoothInfoCubit>()),
            BlocProvider(create: (_) => CalenderCubit()),
            BlocProvider(create: (_) => SelectRangeDateCubit()),
            BlocProvider(create: (_) => di.getIt<DataHomeCubit>()),
          ],
          child: MaterialApp.router(
            routerConfig: router,
            theme: AppTheme.appThemeData,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
