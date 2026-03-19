import 'package:flutter/material.dart';
import '../contract/law_contract.dart';
import '../view/law_view.dart';

class LawScreen extends StatefulWidget {
  const LawScreen({super.key});

  @override
  State<LawScreen> createState() => _LawScreenState();
}

class _LawScreenState extends State<LawScreen> implements LawControllerContract {
  late final LawViewContract view;

  String _selectedFilter = 'All Laws';

  @override
  String get selectedFilter => _selectedFilter;

  @override
  void selectFilter(String filter) {
    setState(() => _selectedFilter = filter);
  }

  @override
  void initState() {
    super.initState();
    view = LawView(controller: this);
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
