import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_constant.dart';
import '../contract/offline_pack_contract.dart';
import '../view/offline_pack_view.dart';




class OfflinePackScreen extends StatefulWidget {
  static const route = 'OfflinePack';
  const OfflinePackScreen({super.key});

  @override
  State<OfflinePackScreen> createState() => _OfflinePackScreenState();
}

class _OfflinePackScreenState extends State<OfflinePackScreen>  with SingleTickerProviderStateMixin 
    implements OfflinePackControllerContract{
  late final OfflinePackViewContract view;



  @override
  void initState() {
    super.initState();

    view = OfflinePackView(controller: this);



  }




  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
  
  @override
  void goToHome() {
context.goNamed(AppRoutes.homeName);
  }
  

}
