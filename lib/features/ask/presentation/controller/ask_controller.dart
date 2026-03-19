import 'package:flutter/material.dart';
import '../contract/ask_contract.dart';
import '../view/ask_view.dart';

const _qa = <String, (String, List<AskSource>)>{
  'Do I pay VAT on electricity?': (
    'Based on the current tax laws, electricity is generally subject to VAT at 7.5%. However, there are reports that electricity may be VAT-free under the new reforms (pending official confirmation).',
    [
      AskSource(name: 'VAT Act Section 2', section: 'Section 2(1)'),
      AskSource(name: 'Finance Act 2023', section: 'Section 15'),
    ],
  ),
  'I dey earn ₦90k monthly—how law take affect me?': (
    'On a ₦90,000 monthly salary, you fall below the minimum wage threshold. Under PITA, you may pay minimum tax of 1% of your gross income (₦900/month). Your employer should deduct PAYE via the payroll system.',
    [
      AskSource(name: 'PITA Section 37', section: 'Minimum Tax'),
      AskSource(name: 'Finance Act 2020', section: 'Section 4'),
    ],
  ),
  'What is minimum tax?': (
    'Minimum tax is 1% of gross income, payable when your computed PAYE tax is lower than 1% of your gross. It ensures everyone earning above the minimum wage contributes to tax.',
    [
      AskSource(name: 'PITA Section 37', section: 'Minimum Tax Provisions'),
      AskSource(name: 'FIRS Circular 2020', section: 'Guideline 3'),
    ],
  ),
  'How much PAYE for ₦150k salary?': (
    'On a ₦150,000 monthly gross salary (₦1.8M annually), after applying CRA (₦200k + 20% of gross), your estimated monthly PAYE is approximately ₦2,250. The minimum tax of 1% (₦1,500/month) would be compared and the higher amount deducted.',
    [
      AskSource(name: 'PITA Section 3', section: 'Charge of Tax'),
      AskSource(name: 'PITA Section 33', section: 'CRA Provisions'),
    ],
  ),
};

class AskScreen extends StatefulWidget {
  const AskScreen({super.key});

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> implements AskControllerContract {
  late final AskViewContract view;

  final TextEditingController _questionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<AskMessage> _messages = [];

  @override
  TextEditingController get questionController => _questionController;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  List<AskMessage> get messages => _messages;

  @override
  void send() {
    final text = _questionController.text.trim();
    if (text.isEmpty) return;
    _questionController.clear();
    _addExchange(text);
  }

  @override
  void sendSuggestion(String text) {
    _questionController.clear();
    _addExchange(text);
  }

  void _addExchange(String question) {
    final match = _qa[question];
    final answerText = match?.$1 ??
        'Based on the available tax laws, I couldn\'t find a direct answer to your question. Please consult a tax professional or visit the FIRS website for official guidance.';
    final sources = match?.$2 ??
        [const AskSource(name: 'FIRS Official Website', section: 'www.firs.gov.ng')];

    setState(() {
      _messages.add(AskMessage(text: question, isUser: true));
      _messages.add(AskMessage(text: answerText, isUser: false, sources: sources));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _questionController.addListener(() => setState(() {}));
    view = AskView(controller: this);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
