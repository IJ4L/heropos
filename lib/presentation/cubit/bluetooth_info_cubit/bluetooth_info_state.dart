part of 'bluetooth_info_cubit.dart';

sealed class BluetoothInfoState extends Equatable {
  const BluetoothInfoState();

  @override
  List<Object> get props => [];
}

final class BluetoothInfoInitial extends BluetoothInfoState {}

final class BluetoothInfoLoaded extends BluetoothInfoState {
  final BluetoothInfo bluetoothInfo;

  const BluetoothInfoLoaded({required this.bluetoothInfo});

  @override
  List<Object> get props => [bluetoothInfo];
}

final class BluetoothInfoLoading extends BluetoothInfoState {}

final class BluetoothInfoError extends BluetoothInfoState {}
