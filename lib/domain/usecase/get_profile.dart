import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class GetProfileUseCase {
  final LocalRepository localRepository;

  GetProfileUseCase({required this.localRepository});

  Future<Profile?> execute() async {
    return await localRepository.getProfile();
  }
}
