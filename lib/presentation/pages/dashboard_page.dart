import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: AppFont.semiBold.s16,
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: const Column(
        children: [
          // Container(
          //   height: 60.h,
          //   width: double.infinity,
          //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          //   decoration: BoxDecoration(
          //     color: AppColor.green,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(16.r),
          //       bottomRight: Radius.circular(16.r),
          //     ),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Pemasukan   :',
          //         style: AppFont.semiBold.s12.copyWith(
          //           color: AppColor.white,
          //         ),
          //       ),
          //       Text(
          //         'Pengeluaran :',
          //         style: AppFont.semiBold.s12.copyWith(
          //           color: AppColor.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
