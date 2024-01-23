import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/presentation/cubit/pembayaran_cubit/pembayaran_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key, required this.change});

  final double change;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.green,
      body: PopScope(
        onPopInvoked: (didPop) {
          context.read<TroliCubit>().reset();
          context.read<PembayaranCubit>().deleteAll();
          context.go(AppRoute.chasier.path);
        },
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("assets/images/img_succes.svg"),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        Center(
                          child: Text(
                            "Transaksi Sukses!",
                            style: AppFont.bold.s20
                                .copyWith(color: AppColor.green),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Note: Jangan lupa memberikan senyum ke\nPelanggan",
                            style: AppFont.regular.s14,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      decoration: BoxDecoration(
                        color: AppColor.green,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Pembayaran: TUNAI",
                            style: AppFont.bold.s16.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          const Divider(),
                          Text(
                            "Kembalian: ${change.toInt().toString().formatCurrency()}",
                            style: AppFont.bold.s16.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: AppColor.white,
                    width: 1,
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Print Struk",
                      style: AppFont.bold.s14.copyWith(color: AppColor.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                child: TextButton(
                  onPressed: () {
                    context.read<TroliCubit>().reset();
                    context.read<PembayaranCubit>().deleteAll();
                    context.go(AppRoute.chasier.path);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Transaksi Selanjutnya",
                      style: AppFont.bold.s14.copyWith(color: AppColor.green),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
