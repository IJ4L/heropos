import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/extension/string_formatter.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/data/models/product_insert_model.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/produk_cubit/produk_cubit.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProdukCubit>().getProduks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Produk",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ProdukCubit, ProdukState>(
              builder: (context, state) {
                if (state is ProdukLoaded) {
                  return ListView.separated(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      var data = state.produks[index];
                      debugPrint("data: ${data.gambarProduk}");
                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 82.h,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(9.r),
                                    bottomLeft: Radius.circular(8.r),
                                  ),
                                  child: data.gambarProduk!.isNotEmpty
                                      ? Image.file(
                                          File(data.gambarProduk.toString()),
                                          width: 120.0,
                                          height: 120.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/img_product_bg.png",
                                          width: 120.0,
                                          height: 120.0,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(width: 15.w),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.namaProduk,
                                      style: AppFont.semiBold.s14,
                                    ),
                                    Text(
                                      data.hargaJual
                                          .toInt()
                                          .toString()
                                          .formatCurrency(),
                                      style: AppFont.bold.s14.copyWith(
                                        color: AppColor.green,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 12.w),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: SizedBox(
                              height: 45,
                              width: 45,
                              child: IconButton(
                                onPressed: () {
                                  context.goNamed(
                                    AppRoute.addproduk.name,
                                    extra: {
                                      "isEdit": true,
                                      "produk": data,
                                    },
                                  );
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.r),
                                      bottomLeft: Radius.circular(8.r),
                                    ),
                                  ),
                                ),
                                icon: const Center(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: AppColor.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: state.produks.length,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CamereCubit>().reset();
          context.goNamed(
            AppRoute.addproduk.name,
            extra: {
              "isEdit": false,
              "produk": Produk(
                namaProduk: "namaProduk",
                kodeProduk: "kodeProduk",
                hargaBeli: 0,
                hargaJual: 0,
                stok: 0,
              )
            },
          );
        },
        backgroundColor: AppColor.green,
        foregroundColor: AppColor.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
