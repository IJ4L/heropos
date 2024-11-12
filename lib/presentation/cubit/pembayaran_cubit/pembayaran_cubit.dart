import 'package:bloc/bloc.dart';

class PembayaranCubit extends Cubit<String> {
  PembayaranCubit() : super("0");

  void addPrice(String angka) {
    String currentValue = state;

    String newValue = currentValue + angka;

    emit(newValue);
  }

  void deleteOne() {
    String currentValue = state;

    String newValue = currentValue.substring(0, currentValue.length - 1);

    if (newValue.isEmpty) {
      newValue = "0";
    }

    emit(newValue);
  }

  void deleteAll() {
    emit("0");
  }
}
