import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tax_app/core/utils/enums.dart';
import '../../../../core/navigation/route_constant.dart';
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

  @override
   List<String> allTopics = [
    'VAT',
    'PAYE',
    'PIT',
    'CIT',
    'Withholding Tax',
    'Stamp Duties',
    'Excise',
    'Incentives',
    'Penalties',
    'Compliance deadlines',
  ];

  @override
  ValueNotifier<Set<String>> selectedTopics = ValueNotifier({"VAT", "PAYE"});
  
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
  ValueNotifier<bool> keyDates =ValueNotifier(false);
  
  @override
  ValueNotifier<bool> monthlySummary =  ValueNotifier(false);
  
  @override
  ValueNotifier<bool> newCirculars =  ValueNotifier(false);
  
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
