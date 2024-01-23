import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class UpdateProfileUseCase {
  final LocalRepository localRepository;

  UpdateProfileUseCase({required this.localRepository});

  Future<int> execute({required Profile profile}) async {
    return await localRepository.updateProfile(profile: profile);
  }
}
