import 'package:flutter/material.dart';
import '../contract/settings_contract.dart';
import '../view/settings_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    implements SettingsControllerContract {
  late final SettingsViewContract view;

  @override
  final List<String> languages = ['English', 'Hausa', 'Yoruba', 'Igbo'];

  @override
  final List<String> roles = ['Individual', 'Small Business', 'Advisor/Accountant'];

  @override
  final List<String> allTopics = [
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

  String _selectedLanguage = 'English';
  String _selectedRole = 'Individual';
  Set<String> _selectedTopics = {'VAT', 'PAYE', 'CIT'};
  bool _keyDates = false;
  bool _newCirculars = false;
  bool _monthlySummary = false;

  @override
  String get selectedLanguage => _selectedLanguage;

  @override
  String get selectedRole => _selectedRole;

  @override
  Set<String> get selectedTopics => _selectedTopics;

  @override
  bool get keyDates => _keyDates;

  @override
  bool get newCirculars => _newCirculars;

  @override
  bool get monthlySummary => _monthlySummary;

  @override
  void selectLanguage(String lang) => setState(() => _selectedLanguage = lang);

  @override
  void selectRole(String role) => setState(() => _selectedRole = role);

  @override
  void toggleTopic(String topic) {
    setState(() {
      final updated = Set<String>.from(_selectedTopics);
      if (updated.contains(topic)) {
        updated.remove(topic);
      } else {
        updated.add(topic);
      }
      _selectedTopics = updated;
    });
  }

  @override
  void toggleKeyDates() => setState(() => _keyDates = !_keyDates);

  @override
  void toggleNewCirculars() => setState(() => _newCirculars = !_newCirculars);

  @override
  void toggleMonthlySummary() => setState(() => _monthlySummary = !_monthlySummary);

  @override
  void initState() {
    super.initState();
    view = SettingsView(controller: this);
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
