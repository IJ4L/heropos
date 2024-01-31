import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_info_cubit/bluetooth_info_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_status_cubit/bluetooth_status_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/pembayaran_cubit/pembayaran_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_cubit/printer_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
    required this.change,
    required this.itemChoose,
    required this.cash,
  });

  final double change;
  final TroliState itemChoose;
  final int cash;

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
                            "pembayaran: TUNAI",
                            style: AppFont.bold.s16.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          const Divider(),
                          Text(
                            "kembalian: ${change.toInt().toString().formatCurrency()}",
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
              SizedBox(height: 10.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: AppColor.white,
                    width: 1,
                  ),
                ),
                child: BlocBuilder<BluetoothStatusCubit, BluetoothStatusState>(
                  builder: (context, state) {
                    var isBluetoothOn = state is BluetoothStatusOn;
                    return BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoaded) {
                          return BlocConsumer<PrinterCubit, PrinterState>(
                            listener: (context, hasil) {
                              if (hasil is PrinterError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColor.red,
                                    content: Text(
                                      hasil.message,
                                      style: AppFont.popSemiBold.s14,
                                    ),
                                  ),
                                );
                              }
                              if (hasil is PrinterSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColor.blue,
                                    content: Text(
                                      "Berhasil mencetak struk",
                                      style: AppFont.popSemiBold.s14,
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, hasil) {
                              return TextButton(
                                onPressed: () {
                                  isBluetoothOn
                                      ? context
                                          .read<PrinterCubit>()
                                          .printStruks(
                                            produk: itemChoose,
                                            profile: state.profile,
                                            cash: cash,
                                            address: context
                                                .read<BluetoothInfoCubit>()
                                                .state
                                                .macAdress,
                                          )
                                      : null;
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                ),
                                child: Center(
                                  child: state is PrinterLoading
                                      ? Container(
                                          width: 30.r,
                                          height: 30.r,
                                          padding: EdgeInsets.all(10.r),
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColor.white,
                                            strokeWidth: 4.5,
                                          ),
                                        )
                                      : Text(
                                          "Test Print",
                                          style: AppFont.semiBold.s14.copyWith(
                                            color: AppColor.white,
                                          ),
                                        ),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    );
                  },
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
