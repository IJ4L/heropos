import 'package:mb_hero_post/domain/repositories/local_repository.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class GetBluetoothInfoUseCase {
  final LocalRepository localRepository;

  GetBluetoothInfoUseCase({required this.localRepository});

  Future<BluetoothInfo> execute() async {
    return await localRepository.getBluetoothInfo();
  }
}
