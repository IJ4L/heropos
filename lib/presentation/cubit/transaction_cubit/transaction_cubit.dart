import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:mb_hero_post/domain/usecase/get_transaction_detail.dart';
import 'package:mb_hero_post/domain/usecase/insert_transaction.dart';
import 'package:mb_hero_post/domain/usecase/insert_transaction_detail.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final InsertTransactionUseCase insertTransaction;
  final InsertTransactionDetailUseCase insertTransactionDetail;
  final GetTransactionDetailUseCase getTransactionDetail;

  TransactionCubit({
    required this.insertTransaction,
    required this.insertTransactionDetail,
    required this.getTransactionDetail,
  }) : super(TransactionInitial());

  Future<int> insertTransactions({required Transactions transaction}) async {
    return await insertTransaction.execute(transaction: transaction);
  }

  void insertTransactionsDetails({
    required TransactionDetail transactionDetail,
  }) {
    insertTransactionDetail.execute(transactionDetail: transactionDetail);
  }

  void getTransactionDetails() async {
    emit(TransactionLoading());
    final result = await getTransactionDetail.execute();
    emit(TransactionSuccess(result));
  }
}
