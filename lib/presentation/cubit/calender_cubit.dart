import 'package:bloc/bloc.dart';

class CalenderCubit extends Cubit<bool> {
  CalenderCubit() : super(false);

  void openCalender(bool status) {
    emit(status);
  }
}

class SelectRangeDateCubit extends Cubit<DateTime> {
  SelectRangeDateCubit() : super(DateTime.now());

  void selectRange(DateTime range) {
    emit(range);
  }
}
