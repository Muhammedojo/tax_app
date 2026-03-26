

import 'package:flutter/material.dart';

import '../../../../core/utils/contract.dart';

abstract class OnboardControllerContract {

late ValueNotifier<String?> selectedRoleId;
 void onRoleSelected(String roleId);
late ValueNotifier<int> currentIndex;
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
