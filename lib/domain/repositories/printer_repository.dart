import 'package:mb_hero_post/config/injector/injector.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class PrinterRepository {
  Future<bool> printTicket({
    required TroliState produk,
    required Profile profile,
    required int cash,
    required String address,
  });
  Future<List<BluetoothInfo>> pairedBluetooths();
  Future<PermissionStatus> bluetoothCheck();
}
