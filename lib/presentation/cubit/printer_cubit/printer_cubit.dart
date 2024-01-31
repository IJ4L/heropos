import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/domain/usecase/print_struk.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  final PrintStrukUseCase printStruk;
  PrinterCubit({required this.printStruk}) : super(PrinterInitial());

  void printStruks({
    required TroliState produk,
    required Profile profile,
    required int cash,
    required String address,
  }) async {
    emit(PrinterLoading());
    var printer = await printStruk.execute(
      produk: produk,
      profile: profile,
      cash: cash,
      address: address,
    );
    if (printer) {
      emit(PrinterSuccess());
    } else {
      emit(const PrinterError('Gagal mencetak struk'));
    }
  }
}
