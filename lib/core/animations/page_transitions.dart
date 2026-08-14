import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// OctaFit page transition — fade + slide (300ms ease-in-out).
class OctaPageTransition extends CustomTransitionPage<void> {
  OctaPageTransition({
    required super.key,
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    bool slideFromRight = true,
  }) : super(
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
              reverseCurve: Curves.easeInOut,
            );

            final offsetBegin = slideFromRight
                ? const Offset(0.08, 0)
                : const Offset(-0.08, 0);

            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: offsetBegin,
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
}

Page<void> buildOctaTransitionPage({
  required GoRouterState state,
  required Widget child,
  bool slideFromRight = true,
}) {
  return OctaPageTransition(
    key: state.pageKey,
    child: child,
    slideFromRight: slideFromRight,
  );
}
