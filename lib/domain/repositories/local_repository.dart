import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';

abstract class LocalRepository {
  Future<int> saveTransaction({required Transactions transaction});
  Future<List<Transactions>> getTransaction();
  Future<int> saveTransactionDetail({
    required TransactionDetail transactionDetail,
  });
  Future<List<TransactionDetail>> getTransactionDetail(int transactionId);
  Future<List<TransactionAndDetails>> getAllTransactionsWithDetails();

  Future<int> insertProfile({required Profile profile});
  Future<int> updateProfile({required Profile profile});
  Future<Profile?> getProfile();

  Future<String> getImageFromGallery();
}
