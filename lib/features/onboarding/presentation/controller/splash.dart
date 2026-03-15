import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_constant.dart';
import '../contract/splash.dart';
import '../view/splash.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin 
    implements SplashControllerContract{
  late final SplashViewContract view;

    late final AnimationController controller;
    @override
  late final Animation<double> fadeIn;

  @override
  void initState() {
    super.initState();

    view = SplashView(controller: this);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    fadeIn = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
  

    onAnimationComplete();
  }

  void onAnimationComplete()async {
   await Future.delayed(Duration(seconds: 5));
   if(mounted){
    context.goNamed(AppRoutes.welcomeName);
   }

  }

  // Future<void> showHomeScreen(Login user) async {
  //   // await GetIt.I.get<LocalStorage>().openDb(
  //   //   user.username ?? "defaultUsername",
  //   // );
  //   // refreshLocalData();
  //   // if (mounted) {
  //   //   context.goNamed(RouteConstant.homePage);
  //   // }
  // }

  void refreshLocalData() {
    // GetIt.I.get<BankCubit>().loadBanksFromDb();
    // GetIt.I.get<CropCubit>().loadCropsFromDb();
    // GetIt.I.get<CooperativeCubit>().loadCooperativesFromDb();
    // GetIt.I.get<LivestockCubit>().loadLivestocksFromDb();
    // GetIt.I.get<LgaCubit>().loadLgasFromDb();
    // GetIt.I.get<WardCubit>().loadWardsFromDb();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
