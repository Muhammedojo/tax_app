import 'package:flutter/material.dart';
import 'package:tax_app/core/data/model/offline_pack.dart';
import '../contract/law_detail_contract.dart';
import '../view/law_detail_view.dart';

class LawDetailScreen extends StatefulWidget {
  final LawRegistry registry;
  final List<LawEntry> entries;

  const LawDetailScreen({
    super.key,
    required this.registry,
    required this.entries,
  });

  @override
  State<LawDetailScreen> createState() => _LawDetailScreenState();
}

class _LawDetailScreenState extends State<LawDetailScreen>
    implements LawDetailControllerContract {
  late final LawDetailViewContract view;

  @override
  void initState() {
    super.initState();
    view = LawDetailView(
      controller: this,
      registry: widget.registry,
      entries: widget.entries,
    );
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
