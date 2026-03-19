import 'package:flutter/material.dart';
import '../contract/law_detail_contract.dart';
import '../view/law_detail_view.dart';

class LawDetailScreen extends StatefulWidget {
  final LawSection section;

  const LawDetailScreen({super.key, required this.section});

  @override
  State<LawDetailScreen> createState() => _LawDetailScreenState();
}

class _LawDetailScreenState extends State<LawDetailScreen>
    implements LawDetailControllerContract {
  late final LawDetailViewContract view;

  @override
  void initState() {
    super.initState();
    view = LawDetailView(controller: this, section: widget.section);
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
