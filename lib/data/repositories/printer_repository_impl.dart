import 'package:mb_hero_post/config/injector/injector.dart';
import 'package:mb_hero_post/data/data_sources/printer_data_source.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/domain/repositories/printer_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PrinterRepositoryImpl implements PrinterRepository {
  final PrinterDataSource printerDataSource;

  PrinterRepositoryImpl({required this.printerDataSource});

  @override
  Future<PermissionStatus> bluetoothCheck() {
    return printerDataSource.bluetoothCheck();
  }

  @override
  Future<List<BluetoothInfo>> pairedBluetooths() {
    return printerDataSource.pairedBluetooths();
  }

  @override
  Future<bool> printTicket({
    required TroliState produk,
    required Profile profile,
    required int cash,
    required String address,
  }) {
    return printerDataSource.printStruk(produk: produk, profile: profile, cash: cash, address: address);
  }
}
