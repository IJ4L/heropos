class DataHomeModel {
  final int revenueAll;
  final double revenueToday;
  final int spendingAll;
  final double spendingToday;
  final int totalProduct;
  final int totalTransaction;
  final int totalTransactionToday;

  DataHomeModel({
    required this.revenueAll,
    required this.revenueToday,
    required this.spendingAll,
    required this.spendingToday,
    required this.totalProduct,
    required this.totalTransaction,
    required this.totalTransactionToday,
  });

  DataHomeModel copyWith(
      {required int totalProduct,
      required int totalTransaction,
      required int totalTransactionToday,
      required int revenueAll,
      required double revenueToday,
      required int spendingAll,
      required double spendingToday}) {
    return DataHomeModel(
      revenueAll: revenueAll,
      revenueToday: revenueToday,
      spendingAll: spendingAll,
      spendingToday: spendingToday,
      totalProduct: totalProduct,
      totalTransaction: totalTransaction,
      totalTransactionToday: totalTransactionToday,
    );
  }
}
