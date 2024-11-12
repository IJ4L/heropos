import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mb_hero_post/config/schema/string_dbms.dart';
import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<int> insertTransaction(Transactions transaction);
  Future<List<Transactions>> getTransactions();
  Future<int> insertTransactionDetail(TransactionDetail transactionDetail);
  Future<List<TransactionDetail>> getTransactionDetails(int transactionId);
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

  Future<Database?> get database;
}

class LocalDataSourceImpl implements LocalDataSource {
  static final LocalDataSourceImpl _instance = LocalDataSourceImpl.internal();
  factory LocalDataSourceImpl() => _instance;

  static Database? _database;
  File? image;
  LocalDataSourceImpl.internal();

  static SharedPreferences? sharedPreferences;
  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(transactions);
        await db.execute(transactionDetails);
        await db.execute(profile);
        await db.execute(pdefaultProfile);
        await db.execute(products);
      },
    );
  }

  @override
  Future<int> insertTransaction(Transactions transaction) async {
    Database? db = await database;
    return await db!.insert('transactions', transaction.toMap());
  }

  @override
  Future<int> insertTransactionDetail(
    TransactionDetail transactionDetail,
  ) async {
    Database? db = await database;
    return await db!.insert('transactionDetails', transactionDetail.toMap());
  }

  @override
  Future<List<Transactions>> getTransactions() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query(
      'transactions',
      orderBy: 'id',
    );
    return List.generate(
      maps.length,
      (i) {
        return Transactions.fromMap(maps[i]);
      },
    );
  }

  @override
  Future<List<TransactionDetail>> getTransactionDetails(
    int transactionId,
  ) async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query(
      'transactionDetails',
      where: 'transactionId = ?',
      whereArgs: [transactionId],
      orderBy: 'id',
    );
    return List.generate(
      maps.length,
      (i) {
        return TransactionDetail.fromMap(maps[i]);
      },
    );
  }

  @override
  Future<List<TransactionAndDetails>> getAllTransactionsWithDetails(
      DateTime startDate) async {
    final Database? db = await database;

    if (db == null) {
      return [];
    }

    final String formattedDate = startDate.toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> transactionMaps = await db.query(
      'transactions',
      where: 'transactionDate LIKE ?',
      whereArgs: ['$formattedDate%'],
      orderBy: 'updated_at',
    );

    return await Future.wait(
      transactionMaps.map((transactionMap) async {
        final transaction = Transactions.fromMap(transactionMap);
        final details = await getTransactionDetails(transaction.id!);
        return TransactionAndDetails(transaction, details);
      }).toList(),
    );
  }

  @override
  Future<Profile?> getProfile() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('profile');

    if (maps.isNotEmpty) {
      return Profile.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> insertProfile({required Profile profile}) async {
    Database? db = await database;
    return await db!.insert('profile', profile.toMap());
  }

  @override
  Future<int> updateProfile({required Profile profile}) async {
    Database? db = await database;
    return await db!.update('profile', profile.toMap(),
        where: 'id = ?', whereArgs: [profile.id]);
  }

  @override
  Future<String> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    String imagePath;

    if (pickedFile != null) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      imagePath =
          '${documentsDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      await File(pickedFile.path).copy(imagePath);
      image = File(imagePath);
    }

    return image!.path;
  }

  @override
  Future<int> insertProduk(Produk produk) async {
    Database? db = await database;
    return await db!.insert(
      'products',
      produk.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> updateProduk(Produk produk) async {
    Database? db = await database;
    return await db!.update(
      'products',
      produk.toMap(),
      where: 'ID = ?',
      whereArgs: [produk.id],
    );
  }

  @override
  Future<int> deleteProduk(int id) async {
    Database? db = await database;
    return await db!.delete('products', where: 'ID = ?', whereArgs: [id]);
  }

  @override
  Future<List<Produk>> getProduk() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('products');
    return List.generate(
      maps.length,
      (index) {
        return Produk.fromMap(maps[index]);
      },
    );
  }

  @override
  Future<BluetoothInfo> getBluetoothInfo() async {
    final tag = sharedPreferences!.getString('tag');
    final address = sharedPreferences!.getString('address');
    return BluetoothInfo(name: tag ?? "", macAdress: address ?? "");
  }

  @override
  Future<void> saveBluetoothInfo(BluetoothInfo bluetoothInfo) async {
    await sharedPreferences!.setString('tag', bluetoothInfo.name);
    await sharedPreferences!.setString('address', bluetoothInfo.macAdress);
    return;
  }

  @override
  Future<int> getTotalProduct() async {
    Database? db = await database;
    return await db!.rawQuery('SELECT COUNT(*) FROM products').then(
      (value) {
        return Sqflite.firstIntValue(value) ?? 0;
      },
    );
  }

  @override
  Future<int> getTotalRevenue() async {
    Database? db = await database;
    return await db!.rawQuery('SELECT SUM(totalAmount) FROM transactions').then(
      (value) {
        return Sqflite.firstIntValue(value) ?? 0;
      },
    );
  }

  @override
  Future<double> getTotalRevenueToday() async {
    final Database? db = await database;

    if (db == null) {
      return 0.0;
    }

    final String todayDate = DateTime.now().toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(totalAmount) AS total FROM transactions WHERE transactionDate LIKE ?',
      ['$todayDate%'],
    );

    return result.isNotEmpty && result.first['total'] != null
        ? (result.first['total'] as num).toDouble()
        : 0.0;
  }

  @override
  Future<int> getTotalTransaction() async {
    Database? db = await database;
    return await db!.rawQuery('SELECT COUNT(*) FROM transactions').then(
      (value) {
        return Sqflite.firstIntValue(value) ?? 0;
      },
    );
  }

  @override
  Future<int> getTotalTransactionToday() async {
    final Database? db = await database;

    if (db == null) {
      return 0;
    }

    final String todayDate = DateTime.now().toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM transactions WHERE transactionDate LIKE ?',
      ['$todayDate%'],
    );

    return result.isNotEmpty ? (result.first['count'] as int?) ?? 0 : 0;
  }

  @override
  Future<int> getTotalSpending() async {
    Database? db = await database;
    return await db!.rawQuery('SELECT SUM(totalAmount) FROM transactions').then(
      (value) {
        return Sqflite.firstIntValue(value) ?? 0;
      },
    );
  }

  @override
  Future<double> getTotalSpendingToday() async {
    final Database? db = await database;

    if (db == null) {
      return 0.0;
    }

    final String todayDate = DateTime.now().toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(Harga_Beli) AS total FROM products WHERE created_at LIKE ?',
      ['$todayDate%'],
    );

    // Safely parse the result as a double
    return result.isNotEmpty && result.first['total'] != null
        ? (result.first['total'] as num).toDouble()
        : 0.0;
  }
}
