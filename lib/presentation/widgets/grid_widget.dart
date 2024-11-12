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

class GridCard extends StatelessWidget {
  const GridCard({
    super.key,
    required this.products,
  });

  final List<Produk> products;

  @override
  Widget build(BuildContext context) {
    final TroliCubit troliCubit = context.read<TroliCubit>();

    return GridView.builder(
      padding: EdgeInsets.all(15.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.9,
        crossAxisCount: 2,
        mainAxisSpacing: 18.r,
        crossAxisSpacing: 18.r,
      ),
      itemCount: products.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return BlocBuilder<TroliCubit, TroliState>(
          builder: (context, state) {
            var products = this.products[index];
            String amountString = products.hargaJual.toInt().toString();
            String formattedAmount = amountString.formatCurrency();
            var qty = state.products.contains(
              ProductModel(
                nameOfProduct: products.namaProduk,
                priceOfProduct: products.hargaJual.toInt().toString(),
                imgOfProduct: products.gambarProduk.toString(),
              ),
            )
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
            return GestureDetector(
              onTap: () {
                troliCubit.addToTroli(
                  ProductModel(
                    nameOfProduct: products.namaProduk,
                    priceOfProduct: products.hargaJual.toInt().toString(),
                    quantity: 1,
                    imgOfProduct: products.gambarProduk.toString(),
                  ),
                  double.parse(products.hargaJual.toInt().toString()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: state.products.contains(
                          ProductModel(
                            nameOfProduct: products.namaProduk,
                            priceOfProduct:
                                products.hargaJual.toInt().toString(),
                            imgOfProduct: products.gambarProduk.toString(),
                          ),
                        )
                            ? AppColor.green
                            : AppColor.white,
                        width: 1.2.r,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                          ),
                          child: products.gambarProduk!.isNotEmpty
                              ? Image.file(
                                  File(products.gambarProduk.toString()),
                                  width: double.infinity,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/img_product_bg.png",
                                  width: double.infinity,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products.namaProduk,
                                style: AppFont.semiBold.s12,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                formattedAmount,
                                style: AppFont.bold.s14.copyWith(
                                  color: AppColor.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  qty == "0"
                      ? const SizedBox()
                      : Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 35.r,
                            width: 35.r,
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),
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
              ),
            );
          },
        );
      },
    );
  }
}
