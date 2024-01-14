import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2300), () {
      context.go(AppRoute.activity.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.green,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Text(
              "Hero Pos",
              style: AppFont.bold.s14.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/img_print.png",
              width: 300.w,
              height: 320.h,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "Manage all your\nPOS transactions",
            style: AppFont.bold.s20,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
