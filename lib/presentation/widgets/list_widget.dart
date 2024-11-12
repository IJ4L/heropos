import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/data/models/product_model.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';

class ListCardWidget extends StatelessWidget {
  const ListCardWidget({
    super.key,
    required this.products,
  });

  final List<Produk> products;

  @override
  Widget build(BuildContext context) {
    final TroliCubit troliCubit = context.read<TroliCubit>();

    return ListView.separated(
      padding: EdgeInsets.all(15.r),
      itemBuilder: (context, index) {
        final products = this.products[index];
        String amountString = products.hargaJual.toInt().toString();
        String formattedAmount = amountString.formatCurrency();
        return BlocBuilder<TroliCubit, TroliState>(
          builder: (context, state) {
            var qty = state.products.contains(ProductModel(
              nameOfProduct: products.namaProduk,
              priceOfProduct: products.hargaJual.toInt().toString(),
              imgOfProduct: products.gambarProduk.toString(),
            ))
                ? state
                    .products[state.products.indexWhere((element) =>
                        element ==
                        ProductModel(
                          nameOfProduct: products.namaProduk,
                          priceOfProduct: products.hargaJual.toInt().toString(),
                          imgOfProduct: products.gambarProduk.toString(),
                        ))]
                    .quantity
                    .toString()
                : "0";
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 82.h,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: state.products.contains(
                        ProductModel(
                          nameOfProduct: products.namaProduk,
                          priceOfProduct: products.hargaJual.toInt().toString(),
                          imgOfProduct: products.gambarProduk.toString(),
                        ),
                      )
                          ? AppColor.green
                          : AppColor.white,
                      width: 1.2.r,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9.r),
                            bottomLeft: Radius.circular(8.r),
                          ),
                          child: products.gambarProduk!.isNotEmpty
                              ? Image.file(
                                  File(products.gambarProduk.toString()),
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/img_product_bg.png",
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                )),
                      SizedBox(width: 15.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products.namaProduk,
                            style: AppFont.semiBold.s14,
                          ),
                          Text(
                            formattedAmount,
                            style: AppFont.bold.s14.copyWith(
                              color: AppColor.green,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          troliCubit.addToTroli(
                            ProductModel(
                              nameOfProduct: products.namaProduk,
                              priceOfProduct:
                                  products.hargaJual.toInt().toString(),
                              quantity: 1,
                              imgOfProduct: products.gambarProduk.toString(),
                            ),
                            double.parse(products.hargaJual.toInt().toString()),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.add,
                          size: 24.r,
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
                qty == "0"
                    ? const SizedBox()
                    : Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          height: 35.r,
                          width: 35.r,
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              qty,
                              style: AppFont.bold.s14.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemCount: products.length,
    );
  }
}
