

import 'package:flutter/material.dart';
import 'package:tax_app/core/utils/enums.dart';

import '../../../../core/utils/contract.dart';

abstract class OnboardControllerContract {

late ValueNotifier<UserRole> selectedRole;
 void onRoleSelected(UserRole role);
late ValueNotifier<int> currentIndex;
late List<String> allTopics;
late ValueNotifier<Set<String>> selectedTopics;
void addTopic(String topic);
 late List<String> languages;
late ValueNotifier<String> selectedLanguage;

 
 late ValueNotifier<bool> keyDates;
   late ValueNotifier<bool>  newCirculars;
  late ValueNotifier<bool>  monthlySummary;

  void setKeyDates() {}

  void setNewCirculars() {}

  void setMonthlySummary() {}

  void onLanguageSelected(String lang) {}

  void goToOffline() {}
 

}

abstract class OnboardViewContract extends BaseViewContract {}
