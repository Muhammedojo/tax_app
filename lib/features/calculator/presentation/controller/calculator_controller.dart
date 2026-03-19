import 'package:flutter/material.dart';
import '../contract/calculator_contract.dart';
import '../view/calculator_view.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    implements CalculatorControllerContract {
  late final CalculatorViewContract view;

  final TextEditingController _salaryController = TextEditingController();
  double? _monthlyGross;
  bool _hasCalculated = false;
  int _selectedTab = 0;

  @override
  TextEditingController get salaryController => _salaryController;

  @override
  double? get monthlyGross => _monthlyGross;

  @override
  bool get hasCalculated => _hasCalculated;

  @override
  int get selectedTab => _selectedTab;

  @override
  void calculate() {
    final raw = _salaryController.text.replaceAll(',', '').trim();
    final parsed = double.tryParse(raw);
    if (parsed == null || parsed <= 0) return;
    setState(() {
      _monthlyGross = parsed;
      _hasCalculated = true;
      _selectedTab = 0;
    });
  }

  @override
  void selectTab(int index) => setState(() => _selectedTab = index);

  @override
  void initState() {
    super.initState();
    _salaryController.addListener(() => setState(() {}));
    view = CalculatorView(controller: this);
  }

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
