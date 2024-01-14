import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';

class CardTotal extends StatelessWidget {
  const CardTotal({
    super.key,
    required this.state, required this.path,
  });

  final TroliState state;
  final String path;

  @override
  Widget build(BuildContext context) {
    final totalHarga = state.totalPrice.toInt().toString();

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          path,
          extra: {"products": state},
        );
      },
      child: Container(
        width: double.infinity,
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        margin: EdgeInsets.only(left: 26.w),
        decoration: BoxDecoration(
          color: AppColor.green,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            const Icon(Icons.shopping_bag, color: AppColor.white),
            SizedBox(width: 10.h),
            Text(
              "${state.products.length} Barang",
              style: AppFont.bold.s16.copyWith(color: AppColor.white),
            ),
            const Spacer(),
            Text(
              totalHarga.formatCurrency(),
              style: AppFont.bold.s16.copyWith(color: AppColor.white),
            ),
          ],
        ),
      ),
    );
  }
}
