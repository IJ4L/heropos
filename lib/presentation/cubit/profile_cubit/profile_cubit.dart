import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/domain/usecase/get_profile.dart';
import 'package:mb_hero_post/domain/usecase/update_profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;

  ProfileCubit({
    required this.getProfile,
    required this.updateProfile,
  }) : super(ProfileInitial());

  void getProfileData() async {
    emit(ProfileLoading());
    final profile = await getProfile.execute();
    emit(ProfileLoaded(profile!));
  }

  void updateProfileData(Profile profile) async {
    emit(ProfileLoading());
    await updateProfile.execute(profile: profile);
    emit(ProfileLoaded(profile));
  }
}
