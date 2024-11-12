import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mb_hero_post/data/models/data_home_model.dart';
import 'package:mb_hero_post/domain/usecase/get_data_home.dart';

class DataHomeCubit extends Cubit<DataHomeModel> {
  final GetTotalProductUseCase getTotalProductUseCase;
  final GetTotalTransactionUseCase getTotalTransactionUseCase;
  final GetTotalTransactionTodayUserCase getTotalTransactionTodayUseCase;
  final GetTotalRevenueCase getRevenueAllUseCase;
  final GetTotalRevenueTodayUseCase getRevenueTodayUseCase;
  final GetTotalSpendingUseCase getSpendingAllUseCase;
  final GetTotalSpendingTodayUseCase getSpendingTodayUseCase;

  DataHomeCubit(
      {required this.getTotalProductUseCase,
      required this.getTotalTransactionUseCase,
      required this.getTotalTransactionTodayUseCase,
      required this.getRevenueAllUseCase,
      required this.getRevenueTodayUseCase,
      required this.getSpendingAllUseCase,
      required this.getSpendingTodayUseCase})
      : super(DataHomeModel(
          revenueAll: 0,
          revenueToday: 0,
          spendingAll: 0,
          spendingToday: 0,
          totalProduct: 0,
          totalTransaction: 0,
          totalTransactionToday: 0,
        ));

  void getDataHome() async {
    var totalProduct = await getTotalProductUseCase.getTotalProduct();
    var totalTransaction =
        await getTotalTransactionUseCase.getTotalTransaction();
    var totalTransactionToday =
        await getTotalTransactionTodayUseCase.getTotalTransactionToday();
    var revenueAll = await getRevenueAllUseCase.getTotalRevenue();
    var revenueToday = await getRevenueTodayUseCase.getTotalRevenueToday();
    var spendingAll = await getSpendingAllUseCase.getTotalSpending();
    var spendingToday = await getSpendingTodayUseCase.getTotalSpending();

    debugPrint(revenueToday.toString());

    emit(state.copyWith(
      totalProduct: totalProduct,
      totalTransaction: totalTransaction,
      totalTransactionToday: totalTransactionToday,
      revenueAll: revenueAll,
      revenueToday: revenueToday,
      spendingAll: spendingAll,
      spendingToday: spendingToday,
    ));
  }
}
