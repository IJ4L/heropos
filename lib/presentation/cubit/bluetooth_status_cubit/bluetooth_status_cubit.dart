import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/domain/usecase/bluetooth_status.dart';
import 'package:permission_handler/permission_handler.dart';

part 'bluetooth_status_state.dart';

class BluetoothStatusCubit extends Cubit<BluetoothStatusState> {
  final BluetoothStatusUseCase bluetoothStatus;

  BluetoothStatusCubit({
    required this.bluetoothStatus,
  }) : super(BluetoothStatusInitial());

  void getBluetoothStatus() async {
    emit(BluetoothStatusLoading());
    final status = await bluetoothStatus.execute();
    switch (status) {
      case PermissionStatus.granted:
        emit(BluetoothStatusOn());
        break;
      case PermissionStatus.denied:
        emit(BluetoothStatusOff());
        break;
      default:
        emit(BluetoothStatusOff());
        break;
    }
  }
}
