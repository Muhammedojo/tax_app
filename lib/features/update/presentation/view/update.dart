import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/update.dart';


class UpdateView extends StatelessWidget implements UpdateViewContract {
  const UpdateView({super.key, required this.controller});

  final UpdateControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return 
    TaxLightScaffold(
      showTopActions: false,
      title: 'Updates',
      showLogo: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          31.5.verticalSpace,
          'Welcome Back'.toText(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            textHeight: 34 / 28,
          ),
          3.5.verticalSpace,

          'Get clarity on the new tax laws'.toText(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
            textHeight: 24 / 16,
          ),
          24.verticalSpace,
          GestureDetector(
            onTap: () {},
            child: actionCards(
              'Updates',
              'Understand what changed, what it means, and what to do.',
              'update',
            ),
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {},
            child: actionCards(
              'Tax Calculator',
              'Calculate your take-home salary: Today vs New rule.',
              'calculator',
            ),
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {},
            child: actionCards(
              'Tax Laws',
              'Search and read official tax laws offline.',
              'law',
            ),
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {},
            child: actionCards(
              'Ask Me',
              'Get answers to your tax questions with sources.',
              'ask',
            ),
          ),
        ],
      ),
    );
  
  
  }

  Card actionCards(String title, String subtitle, String icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.5.r),
      ),
      color: AppColors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon.toSvg(width: 56.sp, height: 56.sp, fit: BoxFit.contain),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title.toText(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    textHeight: 28 / 22,
                  ),
                  3.verticalSpace,
                  subtitle.toText(
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
    );
  }
}
