import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/domain/usecase/get_bluetooth_info.dart';
import 'package:mb_hero_post/domain/usecase/save_bluetooth_Info.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

part 'bluetooth_info_state.dart';

class BluetoothInfoCubit extends Cubit<BluetoothInfo> {
  final GetBluetoothInfoUseCase getBluetoothInfo;
  final SaveBluetoothInfoUseCase saveBluetoothInfo;

  BluetoothInfoCubit(
      {required this.getBluetoothInfo, required this.saveBluetoothInfo})
      : super(BluetoothInfo(name: "", macAdress: ""));

  void getInfo() async {
    final result = await getBluetoothInfo.execute();
    log(result.macAdress.toString());
    emit(result);
  }

  void saveInfo(BluetoothInfo bluetoothInfo) async {
    await saveBluetoothInfo.execute(bluetoothInfo: bluetoothInfo);
  }
}
