import 'package:mb_hero_post/domain/repositories/local_repository.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SaveBluetoothInfoUseCase {
  final LocalRepository localRepository;

  SaveBluetoothInfoUseCase({required this.localRepository});

  Future<void> execute({required BluetoothInfo bluetoothInfo}) async {
    return await localRepository.saveBluetoothInfo(bluetoothInfo);
  }
}
