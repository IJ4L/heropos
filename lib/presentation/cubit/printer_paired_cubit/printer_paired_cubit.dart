import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/domain/usecase/get_paired_bluetooth_printer.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

part 'printer_paired_state.dart';

class PrinterPairedCubit extends Cubit<PrinterPairedState> {
  final GetPairedBluetoothPrinterUseCase getPairedBluetooth;
  PrinterPairedCubit({
    required this.getPairedBluetooth,
  }) : super(PrinterPairedInitial());

  void getPairedBluetoothPack() async {
    emit(PrinterPairedLoading());
    final devices = await getPairedBluetooth.execute();
    emit(PrinterPairedLoaded(devices));
  }

  void resetBluetoothPaired() {
    emit(PrinterPairedInitial());
  }
}
