import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class InsertTransactionDetailUseCase {
  final LocalRepository localRepository;

  InsertTransactionDetailUseCase({required this.localRepository});

  Future<int> execute({required TransactionDetail transactionDetail}) async {
    return await localRepository.saveTransactionDetail(
      transactionDetail: transactionDetail,
    );
  }
}
