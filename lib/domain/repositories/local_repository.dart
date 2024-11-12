import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class LocalRepository {
  Future<int> saveTransaction({required Transactions transaction});
  Future<List<Transactions>> getTransaction();
  Future<int> saveTransactionDetail({
    required TransactionDetail transactionDetail,
  });
  Future<List<TransactionDetail>> getTransactionDetail(int transactionId);
  Future<List<TransactionAndDetails>> getAllTransactionsWithDetails(
      DateTime startDate);

  Future<int> insertProfile({required Profile profile});
  Future<int> updateProfile({required Profile profile});
  Future<Profile?> getProfile();

  Future<int> insertProduk(Produk produk);
  Future<List<Produk>> getProduk();
  Future<int> updateProduk(Produk produk);
  Future<int> deleteProduk(int id);

  Future<int> getTotalTransaction();
  Future<int> getTotalTransactionToday();
  Future<int> getTotalRevenue();
  Future<double> getTotalRevenueToday();
  Future<int> getTotalSpending();
  Future<double> getTotalSpendingToday();
  Future<int> getTotalProduct();

  Future<void> saveBluetoothInfo(BluetoothInfo bluetoothInfo);
  Future<BluetoothInfo> getBluetoothInfo();

  Future<String> getImageFromGallery();
}
