part of 'printer_paired_cubit.dart';

sealed class PrinterPairedState extends Equatable {
  const PrinterPairedState();

  @override
  List<Object> get props => [];
}

final class PrinterPairedInitial extends PrinterPairedState {}

final class PrinterPairedLoading extends PrinterPairedState {}

final class PrinterPairedLoaded extends PrinterPairedState {
  final List<BluetoothInfo> devices;

  const PrinterPairedLoaded(this.devices);

  @override
  List<Object> get props => [devices];
}
