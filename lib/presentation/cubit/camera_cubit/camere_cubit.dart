import 'package:bloc/bloc.dart';
import 'package:mb_hero_post/domain/usecase/get_image_from_galery.dart';

class CamereCubit extends Cubit<String> {
  final GetImageFromGaleryUseCase getImageFromGalery;

  CamereCubit({required this.getImageFromGalery}) : super("");

  Future<void> getImage() async {
    String image = await getImageFromGalery.execute();
    emit(image);
  }

  void setImage(String image) {
    emit(image);
  }

  void reset() {
    emit("");
  }
}
