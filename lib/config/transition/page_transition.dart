import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CostumeTransitionPageBuilder {
  static CustomTransitionPage<void> slideTransition({
    required BuildContext context,
    required GoRouterState state,
    required dynamic page,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage<void> fadeTransition({
    required BuildContext context,
    required GoRouterState state,
    required dynamic page,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: page,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
}
