import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class InsertProdukUseCase {
  final LocalRepository localRepository;

  InsertProdukUseCase({required this.localRepository});

  Future<int> execute({required Produk produks}) async {
    return await localRepository.insertProduk(produks);
  }
}
