

import 'package:flutter/material.dart';
import 'package:tax_app/core/utils/enums.dart';

import '../../../../core/utils/contract.dart';

abstract class OnboardControllerContract {

late ValueNotifier<UserRole> selectedRole;
 void onRoleSelected(UserRole role);
late ValueNotifier<int> currentIndex;
 

}

abstract class OnboardViewContract extends BaseViewContract {}
