import 'package:employee_app/core/route/route_name.dart';
import 'package:employee_app/feature/module_profile/presentation/view/screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../feature/module_asigned/presentation/asigned_screen.dart';
import '../../feature/module_home/presentation/view/screen/home_screen.dart';
import '../../feature/module_news/presentation/view/screen/news_feed_screen.dart';
import '../../main_scaffold.dart';

class AppRouter {
  static final _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RouteName.home.path,
    // redirect: (context, state) {
    // final isAuthenticated = _isAuthenticated();
    // final currentLocation = state.matchedLocation;
    // final publicRoutes = [
    //   RouteName.login.path,
    //   RouteName.signUp.path,
    //   RouteName.error.path,
    // ];
    // final isGoingToPublicRoute = publicRoutes.contains(currentLocation);
    // if (!isAuthenticated && !isGoingToPublicRoute) {
    //   return RouteName.login.path;
    // }
    // if (isAuthenticated && (currentLocation == RouteName.login.path || currentLocation == RouteName.signUp.path)) {
    //   return RouteName.home.path;
    // }
    // return null;
    // },
    routes: [
      GoRoute(
        path: RouteName.login.path,
        name: RouteName.login.name,
        builder: (context, state) => const Text('login screen'),
      ),
      GoRoute(
        path: RouteName.signUp.path,
        name: RouteName.signUp.name,
        builder: (context, state) => const Text('sign up screen'),
      ),
      GoRoute(
        path: RouteName.error.path,
        name: RouteName.error.name,
        builder: (context, state) {
          final error = state.uri.queryParameters['message'] ?? 'Unknown error';
          return Text(error);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: RouteName.home.path,
            name: RouteName.home.name,
            // builder: (context, state) => const HomeScreen(),
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: RouteName.feed.path,
            name: RouteName.feed.name,
            // builder: (context, state) => const NewsFeedScreen(),
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const NewsFeedScreen(),
            ),
          ),
          GoRoute(
            path: RouteName.asigned.path,
            name: RouteName.asigned.name,
            // builder: (context, state) => const AsignedScreen(),
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const AsignedScreen(),
            ),
          ),
          GoRoute(
            path: RouteName.profile.path,
            name: RouteName.profile.name,
            // builder: (context, state) => const ProfileScreen(),
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}
