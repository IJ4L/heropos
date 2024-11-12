import 'package:flutter/material.dart';
import 'package:mb_hero_post/core/themes/app_font.dart';

void showCustomSnackBar(
    BuildContext context, String message, Color color, IconData icon) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        height: 32,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppFont.popSemiBold.s14.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
