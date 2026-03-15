import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../contract/splash.dart';
import '../widgets/general_scaffold.dart';
import '../widgets/tax_logo.dart';

class SplashView extends StatelessWidget implements SplashViewContract {
  const SplashView({super.key, required this.controller});

  final SplashControllerContract controller;

  @override
  Widget build(BuildContext context) {
     return TaxLightScaffold(
      body: FadeTransition(
        opacity: controller.fadeIn,
        child: const Center(
          child: TaxLightLogo(size: 90, showLabel: true),
        ),
      ),
    );
  }
}
