import 'package:get_it/get_it.dart';
import 'injector.dart';

final getIt = GetIt.instance;

void configureDepedencies() async {
  getIt.registerFactory<AppRouteConf>(
    () => AppRouteConf(),
  );
}