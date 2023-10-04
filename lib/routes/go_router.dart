import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mesto_flutter/constants/string_constants.dart';
import 'package:mesto_flutter/data/repository/user_repository.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/features/auth/view/view.dart';
import 'package:mesto_flutter/features/error/view/error_screen.dart';
import 'package:mesto_flutter/features/home/view/view.dart';
import 'package:mesto_flutter/features/splash/view/splash_screen.dart';
import 'package:mesto_flutter/features/user/view/user_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GlobalKey<NavigatorState> _rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter router = GoRouter(
  observers: [TalkerRouteObserver(getIt<Talker>())],
  debugLogDiagnostics: kDebugGoRouter,
  initialLocation: '/splash',
  navigatorKey: _rootNavigationKey,
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: <RouteBase>[
    GoRoute(
        path: '/user',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const UserScreen(),
          );
        }),
    GoRoute(
      path: '/home',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
        path: '/auth',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const AuthScreen(),
          );
        },
        routes: [
          GoRoute(
            path: 'register',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return MaterialPage<void>(
                key: state.pageKey,
                child: const RegisterScreen(),
              );
            },
          ),
        ]),
    GoRoute(
      path: '/splash',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MaterialPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
        );
      },
    ),
  ],
  redirect: (context, state) async {
    UserRepository authUser = getIt<UserRepository>();
    final isUserLoggedIn = await authUser.isUserRegister() ?? false;
    if (state.uri.toString() != '/splash' &&
        !isUserLoggedIn &&
        !state.uri.toString().startsWith('/auth/')) {
      return '/auth';
    }
    return null;
  },
);
