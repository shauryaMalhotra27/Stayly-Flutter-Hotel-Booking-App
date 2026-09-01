import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/views/dashboard_view.dart';
import '../../features/hotel/views/hotel_view.dart';
import '../../features/booking/views/booking_view.dart';
import '../../features/account/views/account_view.dart';
import 'scaffold_with_nav_bar.dart';

/// Centralized router configuration using GoRouter.
class AppRouter {
  AppRouter._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _dashboardNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'dashboard',
  );
  static final _hotelNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'hotel',
  );
  static final _bookingNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'booking',
  );
  static final _accountNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'account',
  );

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/dashboard',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _hotelNavigatorKey,
            routes: [
              GoRoute(
                path: '/hotel',
                builder: (context, state) => const HotelView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _bookingNavigatorKey,
            routes: [
              GoRoute(
                path: '/booking',
                builder: (context, state) => const BookingView(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                builder: (context, state) => const AccountView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
