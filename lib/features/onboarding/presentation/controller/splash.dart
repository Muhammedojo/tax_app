import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../contract/splash.dart';
import '../view/splash.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    implements SplashControllerContract {
  late final SplashViewContract view;

  @override
  void initState() {
    super.initState();

    view = SplashView(controller: this);

    onAnimationComplete();
  }

  void onAnimationComplete() {}

  Future<void> showHomeScreen( user) async {
    // await GetIt.I.get<LocalStorage>().openDb(
    //   user.username ?? "defaultUsername",
    // );
    // refreshLocalData();
    // if (mounted) {
    //   context.goNamed(RouteConstant.homePage);
    // }
  }

  void refreshLocalData() {
    // GetIt.I.get<BankCubit>().loadBanksFromDb();
    // GetIt.I.get<CropCubit>().loadCropsFromDb();
    // GetIt.I.get<CooperativeCubit>().loadCooperativesFromDb();
    // GetIt.I.get<LivestockCubit>().loadLivestocksFromDb();
    // GetIt.I.get<LgaCubit>().loadLgasFromDb();
    // GetIt.I.get<WardCubit>().loadWardsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
