part of 'bluetooth_status_cubit.dart';

sealed class BluetoothStatusState extends Equatable {
  const BluetoothStatusState();

  @override
  List<Object> get props => [];
}

final class BluetoothStatusInitial extends BluetoothStatusState {}

final class BluetoothStatusLoading extends BluetoothStatusState {}

final class BluetoothStatusOn extends BluetoothStatusState {}

final class BluetoothStatusOff extends BluetoothStatusState {}
