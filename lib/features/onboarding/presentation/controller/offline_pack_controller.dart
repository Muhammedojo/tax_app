import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_constant.dart';
import '../bloc/offline_pack/offline_pack_cubit.dart';
import '../contract/offline_pack_contract.dart';
import '../view/offline_pack_view.dart';

class OfflinePackScreen extends StatefulWidget {
  static const route = 'OfflinePack';
  const OfflinePackScreen({super.key});

  @override
  State<OfflinePackScreen> createState() => _OfflinePackScreenState();
}

class _OfflinePackScreenState extends State<OfflinePackScreen>
    with SingleTickerProviderStateMixin
    implements OfflinePackControllerContract {
  late final OfflinePackViewContract view;

  @override
  void initState() {
    super.initState();
    view = OfflinePackView(controller: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfflinePackCubit, OfflinePackState>(
      listenWhen: (_, state) => state is OfflinePackLoaded,
      listener: (context, state) => goToHome(),
      child: view.build(context),
    );
  }

  @override
  void downloadPack() {
    context.read<OfflinePackCubit>().downloadFromServer();
  }

  @override
  void goToHome() {
    context.goNamed(AppRoutes.homeName);
  }
}
