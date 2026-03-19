import 'package:flutter/material.dart';
import '../../../../core/utils/contract.dart';

abstract class CalculatorControllerContract {
  TextEditingController get salaryController;
  double? get monthlyGross;
  bool get hasCalculated;
  int get selectedTab;
  void calculate();
  void selectTab(int index);
}

abstract class CalculatorViewContract extends BaseViewContract {}
