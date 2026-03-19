
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tax_app/core/navigation/route_constant.dart';
import '../contract/welcome_contract.dart';
import '../view/welcome_view.dart';


class WelcomeScreen extends StatefulWidget {
  static const route = 'welcome';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin 
    implements WelcomeControllerContract{
  late final WelcomeViewContract view;



  @override
  void initState() {
    super.initState();

    view = WelcomeView(controller: this);



  }




  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
  
  @override
  void getStarted() {
    context.goNamed(AppRoutes.onboardName);
  }
}
