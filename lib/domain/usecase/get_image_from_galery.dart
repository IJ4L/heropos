import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class GetImageFromGaleryUseCase {
  final LocalRepository localRepository;

  GetImageFromGaleryUseCase({required this.localRepository});

  Future<String> execute() async {
    return await localRepository.getImageFromGallery();
  }
}
