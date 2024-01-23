import 'package:mb_hero_post/data/models/transaction_model.dart';

class TransactionDetail {
  int? id;
  int? transactionId;
  String? itemName;
  int? quantity;
  double? unitPrice;

  TransactionDetail({
    this.id,
    this.transactionId,
    this.itemName,
    this.quantity,
    this.unitPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionId': transactionId,
      'itemName': itemName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory TransactionDetail.fromMap(Map<String, dynamic> map) {
    return TransactionDetail(
      id: map['id'],
      transactionId: map['transactionId'],
      itemName: map['itemName'],
      quantity: map['quantity'],
      unitPrice: map['unitPrice'],
    );
  }
}

class TransactionAndDetails {
  final Transactions transaction;
  final List<TransactionDetail> details;

  TransactionAndDetails(this.transaction, this.details);
}
