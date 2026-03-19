import 'package:flutter/material.dart';
import '../../../../core/utils/contract.dart';

class AskSource {
  const AskSource({required this.name, required this.section});
  final String name;
  final String section;
}

class AskMessage {
  const AskMessage({
    required this.text,
    required this.isUser,
    this.sources,
  });
  final String text;
  final bool isUser;
  final List<AskSource>? sources;
}

abstract class AskControllerContract {
  TextEditingController get questionController;
  ScrollController get scrollController;
  List<AskMessage> get messages;
  void send();
  void sendSuggestion(String text);
}

abstract class AskViewContract extends BaseViewContract {}
