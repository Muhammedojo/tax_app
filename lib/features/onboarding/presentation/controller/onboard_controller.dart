import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_constant.dart';
import '../bloc/role/role_cubit.dart';
import '../bloc/topic/topic_cubit.dart';
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

    context.read<RoleCubit>().loadRolesFromServer();
    context.read<TopicCubit>().loadTopicsFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }

  @override
  void onRoleSelected(String roleId) {
    selectedRoleId.value = roleId;
  }

  @override
  ValueNotifier<String?> selectedRoleId = ValueNotifier(null);

  @override
  ValueNotifier<int> currentIndex = ValueNotifier(1);

  @override
  ValueNotifier<Set<String>> selectedTopics = ValueNotifier({});

  @override
  void addTopic(String topic) {
    final current = Set<String>.from(selectedTopics.value); // new instance
    if (current.contains(topic)) {
      current.remove(topic);
    } else {
      current.add(topic);
    }
    selectedTopics.value = current; // new reference → triggers rebuild
  }

  @override
  late List<String> languages = ['English', 'Hausa', 'Yoruba', 'Igbo'];

  @override
  ValueNotifier<String> selectedLanguage = ValueNotifier('English');

  @override
  ValueNotifier<bool> keyDates = ValueNotifier(false);

  @override
  ValueNotifier<bool> monthlySummary = ValueNotifier(false);

  @override
  ValueNotifier<bool> newCirculars = ValueNotifier(false);

  @override
  void onLanguageSelected(String lang) {
    selectedLanguage.value = lang;
  }

  @override
  void setKeyDates() {
    keyDates.value = !keyDates.value;
  }

  @override
  void setMonthlySummary() {
    monthlySummary.value = !monthlySummary.value;
  }

  @override
  void setNewCirculars() {
    newCirculars.value = !newCirculars.value;
  }

  @override
  void goToOffline() {
    context.goNamed(AppRoutes.offlinePackName);
  }
}
