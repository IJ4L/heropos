import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_model.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final TroliCubit troliCubit = context.read<TroliCubit>();

    return GridView.builder(
      padding: EdgeInsets.all(20.r),
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
            String amountString = products.priceOfProduct;
            String formattedAmount = amountString.formatCurrency();
            return GestureDetector(
              onTap: () {
                troliCubit.addToTroli(
                  ProductModel(
                    nameOfProduct: products.nameOfProduct,
                    priceOfProduct: products.priceOfProduct,
                    quantity: 1,
                  ),
                  double.parse(products.priceOfProduct),
                );
              },
              child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      child: Image.asset(
                        "assets/images/img_wagyu.jpeg",
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
                            products.nameOfProduct,
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
            );
          },
        );
      },
    );
  }
}
