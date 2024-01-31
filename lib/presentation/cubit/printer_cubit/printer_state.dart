part of 'printer_cubit.dart';

sealed class PrinterState extends Equatable {
  const PrinterState();

  @override
  List<Object> get props => [];
}

final class PrinterInitial extends PrinterState {}

final class PrinterLoading extends PrinterState {}

final class PrinterSuccess extends PrinterState {}

final class PrinterError extends PrinterState {
  final String message;

  const PrinterError(this.message);

  @override
  List<Object> get props => [message];
}
