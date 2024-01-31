import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/presentation/cubit/list_card_cubit/list_card_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/produk_cubit/produk_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/troli_cubit/troli_cubit.dart';
import 'package:mb_hero_post/presentation/widgets/costume_icon_button.dart';
import 'package:mb_hero_post/presentation/widgets/floating_price.dart';
import 'package:mb_hero_post/presentation/widgets/grid_widget.dart';
import 'package:mb_hero_post/presentation/widgets/list_widget.dart';

class ChasierPage extends StatefulWidget {
  const ChasierPage({super.key});

  @override
  State<ChasierPage> createState() => _ChasierPageState();
}

class _ChasierPageState extends State<ChasierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mini Kasir",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Divider(
                height: 1,
                color: AppColor.grey.withOpacity(0.5),
              ),
              Container(
                height: 50.h,
                width: double.infinity,
                padding: EdgeInsets.only(left: 20.w),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "Semua Produk",
                      style: AppFont.semiBold.s14,
                    ),
                    const Spacer(),
                    // costumeIconButton(
                    //   iconData: Icons.search_outlined,
                    //   onPressed: () {},
                    // ),
                    costumeIconButton(
                      iconData: Icons.refresh_outlined,
                      onPressed: () {
                        context.read<TroliCubit>().reset();
                      },
                    ),
                    BlocBuilder<ListCardCubit, bool>(
                      builder: (context, state) {
                        return costumeIconButton(
                          iconData:
                              state ? Icons.list_alt_outlined : Icons.grid_view,
                          onPressed: () {
                            context.read<ListCardCubit>().toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ProdukCubit, ProdukState>(
                  builder: (context, state) {
                    if (state is ProdukLoaded) {
                      return BlocBuilder<ListCardCubit, bool>(
                        builder: (context, tampilan) {
                          return tampilan
                              ? ListCardWidget(products: state.produks)
                              : GridCard(products: state.produks);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<TroliCubit, TroliState>(
        builder: (context, state) => state.products.isEmpty
            ? const SizedBox()
            : CardTotal(state: state, path: AppRoute.troli.path),
      ),
    );
  }
}
