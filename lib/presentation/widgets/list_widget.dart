import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_model.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';

class ListCardWidget extends StatelessWidget {
  const ListCardWidget({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final TroliCubit troliCubit = context.read<TroliCubit>();

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.70,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemBuilder: (context, index) {
          final products = this.products[index];
          String amountString = products.priceOfProduct.toString();
          String formattedAmount = amountString.formatCurrency();
          return BlocBuilder<TroliCubit, TroliState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: 82.h,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: state.products.contains(products)
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
                      child: Image.asset(
                        "assets/images/img_wagyu.jpeg",
                        width: 120.0,
                        height: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products.nameOfProduct,
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
                            nameOfProduct: products.nameOfProduct,
                            priceOfProduct: products.priceOfProduct,
                            quantity: 1,
                          ),
                          double.parse(products.priceOfProduct),
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
              );
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemCount: products.length,
      ),
    );
  }
}
