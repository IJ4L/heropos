import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class GetProdukUseCase {
  final LocalRepository localRepository;

  GetProdukUseCase({required this.localRepository});

  Future<List<Produk>> execute() async {
    return await localRepository.getProduk();
  }
}
