import 'package:mb_hero_post/data/data_sources/local_data_source.dart';
import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:mb_hero_post/domain/repositories/local_repository.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDataSource localDataSource;

  LocalRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Transactions>> getTransaction() async {
    return await localDataSource.getTransactions();
  }

  @override
  Future<List<TransactionDetail>> getTransactionDetail(
    int transactionId,
  ) async {
    return await localDataSource.getTransactionDetails(transactionId);
  }

  @override
  Future<int> saveTransaction({required Transactions transaction}) async {
    return await localDataSource.insertTransaction(transaction);
  }

  @override
  Future<int> saveTransactionDetail({
    required TransactionDetail transactionDetail,
  }) async {
    return await localDataSource.insertTransactionDetail(transactionDetail);
  }

  @override
  Future<List<TransactionAndDetails>> getAllTransactionsWithDetails() {
    return localDataSource.getAllTransactionsWithDetails();
  }

  @override
  Future<Profile?> getProfile() {
    return localDataSource.getProfile();
  }

  @override
  Future<int> insertProfile({required Profile profile}) {
    return localDataSource.insertProfile(profile: profile);
  }

  @override
  Future<int> updateProfile({required Profile profile}) {
    return localDataSource.updateProfile(profile: profile);
  }

  @override
  Future<String> getImageFromGallery() {
    return localDataSource.getImageFromGallery();
  }

  @override
  Future<int> deleteProduk(int id) {
    return localDataSource.deleteProduk(id);
  }

  @override
  Future<List<Produk>> getProduk() {
    return localDataSource.getProduk();
  }

  @override
  Future<int> insertProduk(Produk produk) {
    return localDataSource.insertProduk(produk);
  }

  @override
  Future<int> updateProduk(Produk produk) {
    return localDataSource.updateProduk(produk);
  }

  @override
  Future<BluetoothInfo> getBluetoothInfo() {
    return localDataSource.getBluetoothInfo();
  }

  @override
  Future<void> saveBluetoothInfo(BluetoothInfo bluetoothInfo) {
    return localDataSource.saveBluetoothInfo(bluetoothInfo);
  }
}
