import 'package:flutter/material.dart';
import 'package:tax_app/core/utils/enums.dart';
import '../contract/onboard_contract.dart';
import '../view/onboard_view.dart';

class OnboardScreen extends StatefulWidget {
  static const route = '/';
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen>
    with SingleTickerProviderStateMixin
    implements OnboardControllerContract {
  late final OnboardViewContract view;


  @override
  void initState() {
    super.initState();

    view = OnboardView(controller: this);
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }



  @override
  void onRoleSelected(UserRole role) {
selectedRole.value = role;

  }

  @override
  ValueNotifier<UserRole> selectedRole = ValueNotifier(UserRole.none);

  @override
  ValueNotifier<int> currentIndex = ValueNotifier(1);
}
