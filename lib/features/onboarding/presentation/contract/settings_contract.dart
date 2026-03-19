import '../../../../core/utils/contract.dart';

abstract class SettingsControllerContract {
  String get selectedLanguage;
  String get selectedRole;
  Set<String> get selectedTopics;
  bool get keyDates;
  bool get newCirculars;
  bool get monthlySummary;
  List<String> get languages;
  List<String> get roles;
  List<String> get allTopics;
  void selectLanguage(String lang);
  void selectRole(String role);
  void toggleTopic(String topic);
  void toggleKeyDates();
  void toggleNewCirculars();
  void toggleMonthlySummary();
}

abstract class SettingsViewContract extends BaseViewContract {}
