import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class DeleteProdukUseCase {
  final LocalRepository localRepository;

  DeleteProdukUseCase({required this.localRepository});

  Future<int> execute({required int id}) async {
    return await localRepository.deleteProduk(id);
  }
}
