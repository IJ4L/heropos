import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';
import 'package:mb_hero_post/presentation/cubit/camera_cubit/camere_cubit.dart';
import 'package:mb_hero_post/presentation/cubit/profile_cubit/profile_cubit.dart';

class TokoPage extends StatelessWidget {
  const TokoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Tokoku",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  var data = state.profile;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(40.h),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.h),
                          child: data.img.length == 26
                              ? Image.asset(
                                  data.img,
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(data.img),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: AppFont.bold.s16,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            data.email,
                            style: AppFont.normal.s14,
                          ),
                          SizedBox(height: 6.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CamereCubit>().reset();
                              context.pushNamed(
                                AppRoute.editprofile.name,
                                extra: {"profile": data},
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.h),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Edit Profile Toko",
                              style: AppFont.semiBold.s14.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: const BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                IconButtonCostume(
                  title: "Tambah Produk",
                  icon: Icons.add_business_outlined,
                  onPressed: () {
                    context.pushNamed(AppRoute.produk.name);
                  },
                ),
                IconButtonCostume(
                  title: "Struk Pembelian",
                  icon: Icons.developer_board,
                  onPressed: () {
                    context.pushNamed(AppRoute.struk.name);
                  },
                ),
                IconButtonCostume(
                  title: "Pengaturan Printer",
                  icon: Icons.print_outlined,
                  onPressed: () {
                    context.pushNamed(AppRoute.printingtest.name);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(
                    color: AppColor.grey.withOpacity(0.5),
                  ),
                ),
                IconButtonCostume(
                  title: "Hapus Cache",
                  icon: Icons.delete_sweep_outlined,
                  onPressed: () {},
                ),
                IconButtonCostume(
                  title: "Reset Appclition",
                  iconColor: AppColor.red,
                  icon: Icons.restore,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IconButtonCostume extends StatelessWidget {
  const IconButtonCostume({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.iconColor,
  });

  final String title;
  final IconData icon;
  final Function()? onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
      ),
      icon: Row(
        children: [
          Icon(
            icon,
            size: 20.r,
            color: iconColor,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: AppFont.popSemiBold.s14.copyWith(color: iconColor),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 14.r,
          ),
        ],
      ),
    );
  }
}
