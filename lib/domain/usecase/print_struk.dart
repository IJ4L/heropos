import 'package:mb_hero_post/config/injector/injector.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/domain/repositories/printer_repository.dart';

class PrintStrukUseCase {
  final PrinterRepository printRepository;

  PrintStrukUseCase({required this.printRepository});

  Future<bool> execute({
    required TroliState produk,
    required Profile profile,
    required int cash,
    required String address,
  }) async {
    return await printRepository.printTicket(
      produk: produk,
      profile: profile,
      cash: cash,
      address: address,
    );
  }
}
