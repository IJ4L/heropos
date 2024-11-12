import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mb_hero_post/config/transition/page_transition.dart';
import 'package:mb_hero_post/core/routes/app_route_path.dart';
import 'package:mb_hero_post/presentation/pages/add_produk_page.dart';
import 'package:mb_hero_post/presentation/pages/produk_page.dart';
import 'package:mb_hero_post/presentation/pages/dashboard_page.dart';
import 'package:mb_hero_post/presentation/pages/chasier_page.dart';
import 'package:mb_hero_post/presentation/pages/edit_profile_page.dart';
import 'package:mb_hero_post/presentation/pages/home_page.dart';
import 'package:mb_hero_post/presentation/pages/payment_page.dart';
import 'package:mb_hero_post/presentation/pages/payment_success_page.dart';
import 'package:mb_hero_post/presentation/pages/printing_test_page.dart';
import 'package:mb_hero_post/presentation/pages/splash_page.dart';
import 'package:mb_hero_post/presentation/pages/struk_page.dart';
import 'package:mb_hero_post/presentation/pages/toko_page.dart';
import 'package:mb_hero_post/presentation/pages/troli_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

class AppRouteConf {
  GoRouter get router => _router;
  late final _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CostumeTransitionPageBuilder.fadeTransition(
            context: context,
            state: state,
            page: const SplashPage(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Homepage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: AppRoute.activity.path,
                name: AppRoute.activity.path,
                pageBuilder: (context, state) {
                  return CostumeTransitionPageBuilder.fadeTransition(
                    context: context,
                    state: state,
                    page: const ActivityPage(),
                  );
                },
                routes: const [],
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: AppRoute.chasier.path,
                name: AppRoute.chasier.path,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: ChasierPage());
                },
                routes: [
                  GoRoute(
                    path: AppRoute.troli.path,
                    name: AppRoute.troli.name,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return CostumeTransitionPageBuilder.fadeTransition(
                        context: context,
                        state: state,
                        page: const TroliPage(),
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRoute.payment.path,
                    name: AppRoute.payment.name,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      var arg = state.extra! as Map<String, dynamic>;
                      return CostumeTransitionPageBuilder.fadeTransition(
                        context: context,
                        state: state,
                        page: PaymentPage(itemChoose: arg["products"]),
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRoute.paymentsuccess.path,
                    name: AppRoute.paymentsuccess.name,
                    pageBuilder: (
                      BuildContext context,
                      GoRouterState state,
                    ) {
                      var arg = state.extra! as Map<String, dynamic>;
                      return CostumeTransitionPageBuilder.fadeTransition(
                        context: context,
                        state: state,
                        page: PaymentSuccessPage(
                          change: arg["change"],
                          itemChoose: arg["produk"],
                          cash: arg["cash"],
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: AppRoute.toko.path,
                name: AppRoute.toko.path,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: TokoPage());
                },
                routes: [
                  GoRoute(
                    path: AppRoute.struk.path,
                    name: AppRoute.struk.path,
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: StrukPage());
                    },
                  ),
                  GoRoute(
                    path: AppRoute.editprofile.path,
                    name: AppRoute.editprofile.path,
                    pageBuilder: (context, state) {
                      var arg = state.extra! as Map<String, dynamic>;
                      return NoTransitionPage(
                        child: EditProfilePage(
                          profile: arg["profile"],
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: AppRoute.printingtest.path,
                    name: AppRoute.printingtest.path,
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: PrintingTestPage());
                    },
                  ),
                  GoRoute(
                    path: AppRoute.produk.path,
                    name: AppRoute.produk.path,
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: ProdukPage());
                    },
                    routes: [
                      GoRoute(
                        path: AppRoute.addproduk.path,
                        name: AppRoute.addproduk.path,
                        pageBuilder: (context, state) {
                          var arg = state.extra! as Map<String, dynamic>;
                          return NoTransitionPage(
                            child: AddProdukPage(
                              isEdit: arg["isEdit"],
                              produk: arg["produk"],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ],
  );
}
