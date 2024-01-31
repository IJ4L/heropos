import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/config/injector/injector.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:mb_hero_post/presentation/utils/random.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key, required this.itemChoose}) : super(key: key);

  final TroliState itemChoose;

  @override
  Widget build(BuildContext context) {
    final pembayaranCubit = context.read<PembayaranCubit>();
    final transactionCubit = context.read<TransactionCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pembayaran",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          context.read<PembayaranCubit>().deleteAll();
          context.pushNamed(AppRoute.troli.path);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              height: 1,
              color: AppColor.grey.withOpacity(0.5),
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: const BoxDecoration(color: AppColor.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Belanja:", style: AppFont.semiBold.s14),
                  Text(
                    itemChoose.totalPrice.toInt().toString().formatCurrency(),
                    style: AppFont.semiBold.s14.copyWith(color: AppColor.red),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: AppColor.grey.withOpacity(0.5),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              margin: EdgeInsets.all(10.h),
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Input uang",
                    style: AppFont.semiBold.s14,
                  ),
                  SizedBox(height: 6.h),
                  BlocBuilder<PembayaranCubit, String>(
                    builder: (context, state) {
                      return Text(
                        state.formatCurrency(),
                        style: AppFont.semiBold.s20.copyWith(
                          color: state != "0"
                              ? AppColor.black
                              : AppColor.grey.withOpacity(0.6),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.r, right: 10.r, bottom: 10.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                PriceButton(
                                  title: "1",
                                  onTap: () {
                                    pembayaranCubit.addPrice("1");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "2",
                                  onTap: () {
                                    pembayaranCubit.addPrice("2");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "3",
                                  onTap: () {
                                    pembayaranCubit.addPrice("3");
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Expanded(
                            child: Row(
                              children: [
                                PriceButton(
                                  title: "4",
                                  onTap: () {
                                    pembayaranCubit.addPrice("4");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "5",
                                  onTap: () {
                                    pembayaranCubit.addPrice("5");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "6",
                                  onTap: () {
                                    pembayaranCubit.addPrice("6");
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Expanded(
                            child: Row(
                              children: [
                                PriceButton(
                                  title: "7",
                                  onTap: () {
                                    pembayaranCubit.addPrice("7");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "8",
                                  onTap: () {
                                    pembayaranCubit.addPrice("8");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "9",
                                  onTap: () {
                                    pembayaranCubit.addPrice("9");
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Expanded(
                            child: Row(
                              children: [
                                PriceButton(
                                  title: "C",
                                  backgroundColor: AppColor.red,
                                  textColor: AppColor.white,
                                  onTap: () {
                                    pembayaranCubit.deleteAll();
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "0",
                                  onTap: () {
                                    pembayaranCubit.addPrice("0");
                                  },
                                ),
                                SizedBox(width: 5.r),
                                PriceButton(
                                  title: "000",
                                  onTap: () {
                                    pembayaranCubit.addPrice("000");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          PriceButton(
                            title: "Del",
                            backgroundColor: AppColor.red,
                            textColor: AppColor.white,
                            onTap: () {
                              pembayaranCubit.deleteOne();
                            },
                          ),
                          SizedBox(height: 5.r),
                          PriceButton(
                            title: "Enter",
                            backgroundColor: AppColor.green,
                            textColor: AppColor.white,
                            onTap: () {
                              double tunai = double.tryParse(
                                pembayaranCubit.state,
                              )!;
                              if (tunai >= itemChoose.totalPrice) {
                                insertTransactionToDatabase(
                                  itemChoose,
                                  transactionCubit,
                                  pembayaranCubit,
                                );
                                context.pushNamed(
                                  AppRoute.paymentsuccess.path,
                                  extra: {
                                    "change": tunai - itemChoose.totalPrice,
                                    "produk": itemChoose,
                                    "cash": tunai.toInt(),
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void insertTransactionToDatabase(
  TroliState itemChoose,
  TransactionCubit transactionCubit,
  PembayaranCubit pembayaranCubit,
) {
  int id = generateRandomId();

  Transactions transaction = Transactions(
    id: id,
    transactionDate: DateTime.now(),
    totalAmount: itemChoose.totalPrice,
    tunai: int.tryParse(pembayaranCubit.state)!,
  );

  transactionCubit.insertTransactions(
    transaction: transaction,
  );

  for (var i = 0; i < itemChoose.products.length; i++) {
    TransactionDetail transactionDetail = TransactionDetail(
      transactionId: id,
      itemName: itemChoose.products[i].nameOfProduct,
      quantity: itemChoose.products[i].quantity,
      unitPrice: double.tryParse(itemChoose.products[i].priceOfProduct),
    );
    transactionCubit.insertTransactionsDetails(
      transactionDetail: transactionDetail,
    );
  }
}

class PriceButton extends StatelessWidget {
  const PriceButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.backgroundColor = AppColor.white,
    this.textColor = AppColor.black,
  }) : super(key: key);

  final String title;
  final Color backgroundColor, textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppFont.semiBold.s16.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
