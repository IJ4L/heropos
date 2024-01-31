import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/config/injector/injector.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_model.dart';
import 'package:mb_hero_post/data/models/profile_model.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_info_cubit/bluetooth_info_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/bluetooth_status_cubit/bluetooth_status_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_cubit/printer_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/printer_paired_cubit/printer_paired_cubit.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PrintingTestPage extends StatefulWidget {
  const PrintingTestPage({super.key});

  @override
  State<PrintingTestPage> createState() => _PrintingTestPageState();
}

class _PrintingTestPageState extends State<PrintingTestPage> {
  @override
  void initState() {
    super.initState();
    context.read<BluetoothStatusCubit>().getBluetoothStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengaturan Printer",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: BlocConsumer<BluetoothStatusCubit, BluetoothStatusState>(
        listener: (context, state) {
          if (state is BluetoothStatusOn) {
            context.read<PrinterPairedCubit>().getPairedBluetoothPack();
          }
          if (state is BluetoothStatusOff) {
            context.read<PrinterPairedCubit>().resetBluetoothPaired();
          }
        },
        builder: (context, state) {
          var isBluetoothOn = state is BluetoothStatusOn;
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: BlocBuilder<PrinterPairedCubit, PrinterPairedState>(
                  builder: (context, state) {
                    if (state is PrinterPairedLoaded) {
                      List<DropdownMenuItem<BluetoothInfo>> item = state.devices
                          .map(
                            (data) => DropdownMenuItem(
                              value: data,
                              child: Text(
                                data.name,
                                style: AppFont.popSemiBold.s14.copyWith(
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                          )
                          .toList();
                      return DropdownButtonFormField(
                        hint: const Text("Pilih Printer"),
                        style: AppFont.popSemiBold.s14.copyWith(
                          color: AppColor.black,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        dropdownColor: AppColor.white,
                        borderRadius: BorderRadius.circular(6.r),
                        elevation: 1,
                        items: item,
                        onChanged: (value) {
                          context.read<BluetoothInfoCubit>().saveInfo(value!);
                          context.read<BluetoothInfoCubit>().getInfo();
                        },
                      );
                    }
                    return DropdownButtonFormField(
                      hint: const Text("Pilih Printer"),
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      dropdownColor: AppColor.white,
                      borderRadius: BorderRadius.circular(6.r),
                      elevation: 1,
                      items: const [],
                      onChanged: (value) {},
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 40.h,
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: BlocConsumer<PrinterCubit, PrinterState>(
                  listener: (context, state) {
                    if (state is PrinterError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColor.red,
                          content: Text(
                            state.message,
                            style: AppFont.popSemiBold.s14,
                          ),
                        ),
                      );
                    }
                    if (state is PrinterSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColor.green,
                          content: Text(
                            "Berhasil mencetak struk",
                            style: AppFont.popSemiBold.s14,
                          )
                        )
                      );
                    }
                  },
                  builder: (BuildContext context, PrinterState state) {
                    return ElevatedButton(
                      onPressed: () {
                        isBluetoothOn
                            ? context.read<PrinterCubit>().printStruks(
                                  produk: TroliState(
                                    [
                                      ProductModel(
                                        nameOfProduct: "Mie Ayam",
                                        priceOfProduct: "5000",
                                        imgOfProduct:
                                            "assets/images/mie_ayam.png",
                                      )
                                    ],
                                    5000,
                                  ),
                                  profile: Profile(
                                    name: "Hero",
                                    alamat: "Jl. Jendral Sudirman",
                                    email: "l3KpY@example.com",
                                    phone: "081234567890",
                                    img: "assets/images/hero.png",
                                  ),
                                  cash: 10000,
                                  address: context
                                      .read<BluetoothInfoCubit>()
                                      .state
                                      .macAdress,
                                )
                            : null;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isBluetoothOn ? AppColor.green : AppColor.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.h),
                        ),
                        elevation: 0,
                      ),
                      child: state is PrinterLoading
                          ? Container(
                              width: 30.r,
                              height: 30.r,
                              padding: EdgeInsets.all(10.r),
                              child: const CircularProgressIndicator(
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
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
