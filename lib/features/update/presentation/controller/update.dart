import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api/repository/repository_contract.dart';
import '../../../update/presentation/bloc/update/update_cubit.dart';
import '../contract/update.dart';
import '../view/update.dart';

class UpdateScreen extends StatefulWidget {
  static const route = '/';
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen>
    implements UpdateControllerContract {
  late final UpdateViewContract view;

  @override
  void initState() {
    super.initState();

    view = UpdateView(controller: this);
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }
}
