import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class GetTransactionDetailUseCase {
  final LocalRepository localRepository;

  GetTransactionDetailUseCase({required this.localRepository});

  Future<List<TransactionAndDetails>> execute() async {
    return await localRepository.getAllTransactionsWithDetails();
  }
}
