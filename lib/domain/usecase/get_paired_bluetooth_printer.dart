import 'package:mb_hero_post/domain/repositories/printer_repository.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class GetPairedBluetoothPrinterUseCase {
  final PrinterRepository printRepository;

  GetPairedBluetoothPrinterUseCase({required this.printRepository});

  Future<List<BluetoothInfo>> execute() async {
    return await printRepository.pairedBluetooths();
  }
}
