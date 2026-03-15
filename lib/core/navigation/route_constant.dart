

/// Central place for all route paths and names.
///
/// Convention:
///   - [path]  → the literal GoRouter path string (used in [GoRoute.path])
///   - [name]  → a stable name string (used with [context.goNamed])
///
/// Always add new routes here and reference them by constant to avoid
/// hard-coded strings scattered across the codebase.
abstract class AppRoutes {
  AppRoutes._();

  // ── Onboarding ────────────────────────────────────────────────────────────

  static const String splash = '/';
  static const String splashName = 'splash';

  static const String welcome = '/welcome';
  static const String welcomeName = 'welcome';

  static const String onboardingStep1 = '/onboarding/step-1';
  static const String onboardingStep1Name = 'onboarding-step-1';

  static const String onboardingStep2 = '/onboarding/step-2';
  static const String onboardingStep2Name = 'onboarding-step-2';

  // ── Add future routes below ───────────────────────────────────────────────
  // static const String home = '/home';
  // static const String homeName = 'home';
}