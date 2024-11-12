import 'dart:io';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/transaction_detail_model.dart';
import 'package:mb_hero_post/data/models/transaction_model.dart';
import 'package:mb_hero_post/presentation/cubit/calender_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:mb_hero_post/presentation/utils/date_formatter.dart';

class StrukPage extends StatefulWidget {
  const StrukPage({Key? key}) : super(key: key);

  @override
  State<StrukPage> createState() => _StrukPageState();
}

class _StrukPageState extends State<StrukPage> {
  @override
  void initState() {
    super.initState();
    context.read<SelectRangeDateCubit>().selectRange(DateTime.now());
    context.read<TransactionCubit>().getTransactionDetails(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final calenderCubit = context.read<CalenderCubit>();
    final selectRangeCubit = context.read<SelectRangeDateCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Struk Pembelian",
          style: AppFont.semiBold.s16,
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
            calenderCubit.openCalender(false);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: GestureDetector(
        onTap: () {
          calenderCubit.openCalender(false);
        },
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionSuccess) {
              return Stack(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.only(
                      top: 60.h,
                      left: 20.w,
                      right: 20.w,
                      bottom: 20.h,
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
                  Column(
                    children: [
                      Container(
                        height: 40.h,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          top: 10.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                        child: IconButton(
                          onPressed: () {
                            calenderCubit.openCalender(
                              !calenderCubit.state,
                            );
                          },
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColor.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: BlocBuilder<SelectRangeDateCubit, DateTime>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$state".toDateOnlyRange(),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.perm_contact_calendar_outlined,
                                    color: AppColor.green,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      BlocBuilder<CalenderCubit, bool>(
                        builder: (context, state) {
                          // final thisDate = DateTime.now();
                          if (state) {
                            return Container(
                              width: double.infinity,
                              height: 350,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.green),
                              ),
                              child:
                                  BlocBuilder<SelectRangeDateCubit, DateTime>(
                                builder: (context, state) {
                                  var thisDate = DateTime.now();
                                  return DatePicker(
                                    minDate: DateTime(2020, 10, 10),
                                    maxDate: DateTime(2025, 10, 30),
                                    initialDate: thisDate,
                                    currentDate: thisDate,
                                    selectedDate: state,
                                    onDateSelected: (value) {
                                      calenderCubit.openCalender(false);
                                      selectRangeCubit.selectRange(value);
                                      context
                                          .read<TransactionCubit>()
                                          .getTransactionDetails(
                                            value,
                                          );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildTransactionCard(TransactionAndDetails produk) {
    double kembalian =
        produk.transaction.tunai!.toDouble() - produk.transaction.totalAmount!;
    return ClipPath(
      clipper: ZigzagClipper(),
      child: Container(
        height: (MediaQuery.of(context).size.height * 0.5.h) +
            (produk.details.length * 30.h),
        width: MediaQuery.of(context).size.width * 0.74.w,
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 15.h,
        ),
        decoration: const BoxDecoration(
          color: AppColor.white,
        ),
        child: Column(
          children: [
            buildStoreDetails(),
            SizedBox(height: 20.h),
            buildTransactionInfo(produk.transaction),
            SizedBox(height: 20.h),
            buildOrderType(),
            SizedBox(height: 10.h),
            buildOrderDetails(produk.details),
            buildTotalAmountRow(produk.transaction.totalAmount!, "Total"),
            buildTotalAmountRow(produk.transaction.tunai!.toDouble(), "Tunai"),
            buildTotalAmountRow(kembalian, "Kembalian"),
            SizedBox(height: 20.h),
            buildThankYouMessage(),
          ],
        ),
      ),
    );
  }

  Widget buildStoreDetails() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          var data = state.profile;
          return Column(
            children: [
              Container(
                height: 70.r,
                width: 70.r,
                margin: EdgeInsets.symmetric(vertical: 20.h),
                decoration: const BoxDecoration(
                  color: AppColor.green,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.h),
                  child: data.img.length == 26
                      ? Image.asset(
                          "assets/images/img_toko.png",
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(data.img),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Text(
                data.name,
                style: AppFont.semiBold.s20.copyWith(
                  color: AppColor.black,
                ),
              ),
              Text(
                data.alamat,
                style: AppFont.regular.s12.copyWith(
                  color: AppColor.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                data.phone,
                style: AppFont.regular.s12.copyWith(
                  color: AppColor.black.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          );
        }
        return const SizedBox();
      },
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
    return Expanded(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
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

class ZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double zigzagHeight = 14;
    int zigzagCount = 28;

    for (int i = 0; i < zigzagCount; i++) {
      path.lineTo((size.width / zigzagCount) * (i + 0.5),
          i % 2 == 0 ? zigzagHeight : 0);
    }
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);

    for (int i = zigzagCount; i > 0; i--) {
      path.lineTo((size.width / zigzagCount) * (i - 0.5),
          i % 2 == 0 ? size.height - zigzagHeight : size.height);
    }
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
