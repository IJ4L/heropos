import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class InsertTransactionUseCase {
  final LocalRepository localRepository;

  InsertTransactionUseCase({required this.localRepository});

  Future<int> execute({required Transactions transaction}) async {
    return await localRepository.saveTransaction(transaction: transaction);
  }
}
