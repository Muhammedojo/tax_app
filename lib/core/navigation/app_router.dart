import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tax_app/features/home/controllers/home_controller.dart';
import 'package:tax_app/features/onboarding/presentation/controller/offline_pack_controller.dart';
import 'package:tax_app/features/onboarding/presentation/controller/onboard_controller.dart';

import '../../features/onboarding/presentation/controller/splash.dart';
import '../../features/onboarding/presentation/controller/welcome_controller.dart';
import '../../features/update/presentation/controller/update.dart';
import 'route_constant.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splashName,
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      name: AppRoutes.welcomeName,
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: WelcomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.onboard,
      name: AppRoutes.onboardName,
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: OnboardScreen()),
    ),
    GoRoute(
      path: AppRoutes.offlinePack,
      name: AppRoutes.offlinePackName,
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: OfflinePackScreen()),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: HomeScreen()),
    ),

    GoRoute(
      path: AppRoutes.update,
      name: AppRoutes.updateName,
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: UpdateScreen()),
    ),
    // GoRoute(
    //   path: AppRoutes.onboardingStep2,
    //   name: AppRoutes.onboardingStep2Name,
    //   pageBuilder: (context, state) => _buildPage(
    //     state: state,
    //     child: OnboardingStep2Screen(
    //       onContinue: (role) {
    //         // Navigate to your home/dashboard once role is picked.
    //         // Replace with your actual next route e.g.:
    //         // context.goNamed(AppRoutes.homeName, extra: role)
    //       },
    //       onSkip: () {
    //         // context.goNamed(AppRoutes.homeName)
    //       },
    //       onThemeToggle: _onToggleTheme,
    //     ),
    //   ),
    // ),
  ],

  // ── Error page ────────────────────────────────────────────────────────
  errorPageBuilder: (context, state) => _buildPage(
    state: state,
    child: Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.error}',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);

/// Wraps every screen in a [CustomTransitionPage] with a consistent
/// fade transition to match the AnimatedSwitcher feel from main.dart.
CustomTransitionPage<void> _buildPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      );
    },
  );
}
