import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/home_contract.dart';


class HomeView extends StatelessWidget
    implements HomeViewContract {
  const HomeView({super.key, required this.controller});

  final HomeControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(

      showTopActions: true,
      title: 'Home',
      showLogo: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         31.5.verticalSpace,
         'Welcome Back'.toText(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          textHeight: 34/28
         ),3.5.verticalSpace,
      
         'Get clarity on the new tax laws'.toText(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
          textHeight: 24/16
         ),24.verticalSpace,
        Card(
  elevation: 4, // Adjust this value (0-24) for more/less shadow
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24.5.r),
  ),
  color: AppColors.white,
  margin: EdgeInsets.zero, // Remove default margin if you don't want spacing around the card
  child: Padding(
    padding: REdgeInsets.all(24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'update'.toSvg(
          width: 56.sp,
          height: 56.sp,
          fit: BoxFit.contain,
        ),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Added for proper text alignment
            children: [
              'Updates'.toText(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                textHeight: 28 / 22,
              ),
              3.verticalSpace,
              'Understand what changed, what it means, and what to do'.toText(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
                textHeight: 20 / 14,
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
        //  18.verticalSpace
        ],
      ),
    );
  }
}
