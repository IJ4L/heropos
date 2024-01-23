import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:mb_hero_post/presentation/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:mb_hero_post/presentation/utils/date_formatter.dart';

class StrukPage extends StatefulWidget {
  const StrukPage({Key? key}) : super(key: key);

  @override
  State<StrukPage> createState() => _StrukPageState();
}

class _StrukPageState extends State<StrukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Struk",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.date_range,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 20.w,
                    ),
                    itemCount: state.transactions.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return buildTransactionCard(state.transactions[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10.w);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildTransactionCard(TransactionAndDetails produk) {
    double kembalian =
        produk.transaction.tunai!.toDouble() - produk.transaction.totalAmount!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.64.h,
      width: MediaQuery.of(context).size.width * 0.74.w,
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
        vertical: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColor.white,
      ),
      child: Column(
        children: [
          buildStoreLogo(),
          buildStoreDetails(),
          SizedBox(height: 20.h),
          buildTransactionInfo(produk.transaction),
          SizedBox(height: 20.h),
          buildOrderType(),
          SizedBox(height: 10.h),
          buildOrderDetails(produk.details),
          const Spacer(),
          buildTotalAmountRow(produk.transaction.totalAmount!, "Total"),
          buildTotalAmountRow(produk.transaction.tunai!.toDouble(), "Tunai"),
          buildTotalAmountRow(kembalian, "Kembalian"),
          SizedBox(height: 20.h),
          buildThankYouMessage(),
        ],
      ),
    );
  }

  Widget buildStoreLogo() {
    return Container(
      height: 70.r,
      width: 70.r,
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: const BoxDecoration(
        color: AppColor.green,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildStoreDetails() {
    return Column(
      children: [
        Text(
          "POST CAFE BINTARO",
          style: AppFont.semiBold.s20.copyWith(
            color: AppColor.black,
          ),
        ),
        Text(
          "Alamat lengkap toko",
          style: AppFont.regular.s12.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          "0812345326789",
          style: AppFont.regular.s12.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
        ),
        SizedBox(height: 5.h),
      ],
    );
  }

  Widget buildTransactionInfo(Transactions transaction) {
    return Column(
      children: [
        buildTransactionDateAndId(transaction),
        buildTransactionTypeAndId(transaction),
        SizedBox(height: 5.h),
      ],
    );
  }

  Row buildTransactionDateAndId(Transactions transaction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          formatDate(transaction.transactionDate!),
          style: AppFont.popSemiBold.s14.copyWith(
            color: AppColor.black,
          ),
        ),
      ],
    );
  }

  Row buildTransactionTypeAndId(Transactions transaction) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Transaksi",
          style: AppFont.popSemiBold.s14.copyWith(
            color: AppColor.black,
          ),
        ),
        Text(
          "TRX${transaction.id}",
          style: AppFont.popSemiBold.s14.copyWith(
            color: AppColor.black,
          ),
        ),
      ],
    );
  }

  Widget buildOrderType() {
    return Column(
      children: [
        Text(
          "--- Tipe pesanan ---",
          style: AppFont.regular.s14.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget buildOrderDetails(List<TransactionDetail> details) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height * 0.038.h) * details.length,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, innerIndex) {
          var detail = details[innerIndex];
          double unitPrice = detail.unitPrice! * detail.quantity!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.itemName!,
                style: AppFont.semiBold.s14,
              ),
              rowText(
                unitPrice.toInt().toString(),
                "${detail.quantity!} x ${detail.unitPrice!.toInt().toString().formatCurrency()}",
              )
            ],
          );
        },
        separatorBuilder: (context, innerIndex) => const SizedBox(height: 8),
        itemCount: details.length,
      ),
    );
  }

  Row buildTotalAmountRow(double amount, String title) {
    return rowText(amount.toInt().toString(), title);
  }

  Row rowText(var value, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppFont.popSemiBold.s14,
        ),
        Text(
          value.toString().formatCurrency(),
          style: AppFont.popSemiBold.s14,
        ),
      ],
    );
  }

  Widget buildThankYouMessage() {
    return Column(
      children: [
        Text(
          "--- Terima kasih ---",
          style: AppFont.regular.s14.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
