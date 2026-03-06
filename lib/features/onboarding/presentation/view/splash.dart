import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../contract/splash.dart';

class SplashView extends StatelessWidget implements SplashViewContract {
  const SplashView({super.key, required this.controller});

  final SplashControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset('assets/vectors/appLogo.svg', fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
