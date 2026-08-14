import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:octafitv2/core/routing/app_routers.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRouters.splash,
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => AppRouters.splash,
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);

