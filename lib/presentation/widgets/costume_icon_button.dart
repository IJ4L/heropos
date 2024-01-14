import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mb_hero_post/core/themes/app_color.dart';

Container costumeIconButton({
  required IconData iconData,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 55.h,
    width: 55.w,
    decoration: BoxDecoration(
      border: Border.symmetric(
        vertical: BorderSide(
          color: AppColor.grey.withOpacity(0.5),
        ),
      ),
    ),
    child: IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(8.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      icon: Icon(iconData),
    ),
  );
}
