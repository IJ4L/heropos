import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mb_hero_post/config/schema/string_dbms.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDataSource {
  Future<int> insertTransaction(Transactions transaction);
  Future<List<Transactions>> getTransactions();
  Future<int> insertTransactionDetail(TransactionDetail transactionDetail);
  Future<List<TransactionDetail>> getTransactionDetails(int transactionId);
  Future<List<TransactionAndDetails>> getAllTransactionsWithDetails();

  Future<int> insertProfile({required Profile profile});
  Future<int> updateProfile({required Profile profile});
  Future<Profile?> getProfile();

  Future<String> getImageFromGallery();

  Future<Database?> get database;
}

class LocalDataSourceImpl implements LocalDataSource {
  static final LocalDataSourceImpl _instance = LocalDataSourceImpl.internal();
  factory LocalDataSourceImpl() => _instance;

  static Database? _database;

  File? image;

  LocalDataSourceImpl.internal();

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
      version: 6,
      onCreate: (Database db, int version) async {
        await db.execute(transactions);
        await db.execute(transactionDetails);
        await db.execute(profile);
        await db.execute(pdefaultProfile);
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
  Future<List<TransactionAndDetails>> getAllTransactionsWithDetails() async {
    Database? db = await database;
    List<Map<String, dynamic>> transactionMaps = await db!.query(
      'transactions',
      orderBy: 'id',
    );

    return Future.wait(
      transactionMaps.map(
        (transactionMap) async {
          Transactions transaction = Transactions.fromMap(transactionMap);
          List<TransactionDetail> details = await getTransactionDetails(
            transaction.id!,
          );
          return TransactionAndDetails(transaction, details);
        },
      ),
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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    String imagePath;

    if (pickedFile != null) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      imagePath = '${documentsDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

      await File(pickedFile.path).copy(imagePath);
      image = File(imagePath);
    }

    return image!.path;
  }
}
