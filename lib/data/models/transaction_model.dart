class Transactions {
  int? id;
  DateTime? transactionDate;
  double? totalAmount;
  int? tunai;

  Transactions({
    this.id,
    this.transactionDate,
    this.totalAmount,
    this.tunai,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionDate': transactionDate?.toIso8601String(),
      'totalAmount': totalAmount,
      'tunai': tunai, 
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: map['id'],
      transactionDate: DateTime.parse(map['transactionDate']),
      totalAmount: map['totalAmount'],
      tunai: map['tunai'],
    );
  }
}
