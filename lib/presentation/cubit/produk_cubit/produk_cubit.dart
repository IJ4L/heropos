import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/domain/usecase/delete_produk.dart';
import 'package:mb_hero_post/domain/usecase/get_produk.dart';
import 'package:mb_hero_post/domain/usecase/insert_produk.dart';
import 'package:mb_hero_post/domain/usecase/update_produk.dart';

part 'produk_state.dart';

class ProdukCubit extends Cubit<ProdukState> {
  final InsertProdukUseCase insertProdukUseCase;
  final UpdateProdukUseCase updateProdukUseCase;
  final GetProdukUseCase getProdukUseCase;
  final DeleteProdukUseCase deleteProdukUseCase;

  ProdukCubit({
    required this.insertProdukUseCase,
    required this.updateProdukUseCase,
    required this.getProdukUseCase,
    required this.deleteProdukUseCase,
  }) : super(ProdukInitial());

  void getProduks() async {
    emit(ProdukLoading());
    final List<Produk> produks = await getProdukUseCase.execute();
    emit(ProdukLoaded(produks));
  }

  void addProduk(Produk produk) {
    insertProdukUseCase.execute(produks: produk);
  }

  void updateProduks(Produk produk) {
    updateProdukUseCase.execute(produk);
  }

  void deleteProduk(int id) {
    deleteProdukUseCase.execute(id: id);
  }
}
