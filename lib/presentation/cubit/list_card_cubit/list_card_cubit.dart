import 'package:bloc/bloc.dart';

class ListCardCubit extends Cubit<bool> {
  ListCardCubit() : super(false);

  void toggle() => emit(!state);
}
