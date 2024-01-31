part of 'produk_cubit.dart';

sealed class ProdukState extends Equatable {
  const ProdukState();

  @override
  List<Object> get props => [];
}

final class ProdukInitial extends ProdukState {}

final class ProdukLoading extends ProdukState {}

final class ProdukLoaded extends ProdukState {
  final List<Produk> produks;

  const ProdukLoaded(this.produks);

  @override
  List<Object> get props => [produks];
}
