import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class UpdateProdukUseCase {
  final LocalRepository localRepository;

  UpdateProdukUseCase({required this.localRepository});

  Future<int> execute(Produk produk) async {
    return await localRepository.updateProduk(produk);
  }
}
