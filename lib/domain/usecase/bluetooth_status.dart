import 'package:mb_hero_post/domain/repositories/printer_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothStatusUseCase {
  final PrinterRepository printRepository;

  BluetoothStatusUseCase({required this.printRepository});

  Future<PermissionStatus> execute() async {
    return await printRepository.bluetoothCheck();
  }
}
