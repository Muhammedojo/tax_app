import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/theme/colors.dart';
import '../contract/welcome_contract.dart';
import '../widgets/general_scaffold.dart';
import '../widgets/tax_button.dart';

class WelcomeView extends StatelessWidget implements WelcomeViewContract {
  const WelcomeView({super.key, required this.controller});

  final WelcomeControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: true,
      noHeader: true,
      body: Column(
        children: [
           171.verticalSpace,
       
          // Logo
        SvgPicture.asset('assets/vectors/logo_text.svg', fit: BoxFit.contain, width: 114.sp, height: 138.sp,),
       
         24.verticalSpace,
       
          // Headline
         'Shine a Light on the New Tax Laws.'.toText(textAlign: TextAlign.center,
         fontWeight: FontWeight.w700,fontSize: 18
         ),
       
          const SizedBox(height: 10),
       
          // Subtitle
                  'Updates, quick checks, your questions, and a\nlaw checker — all in one place'.toText(
        color: AppColors.secondaryText,
        textAlign: TextAlign.center,
        fontSize: 14,
        fontWeight: FontWeight.w400,
       ),
       
          56.verticalSpace,
       
          // CTA buttons
          TaxLightButton(
            label: 'Get Started',
            onPressed: (){
              controller.getStarted();
            },
          ),
       
          17.verticalSpace,
       
          TaxLightButton(
            label: 'Browse First',
            onPressed: (){},
            variant: TaxLightButtonVariant.ghost,
          ),
       
          const SizedBox(height: 16),
       
          // No account note
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 16.sp,
                // color: AppColors.textSecondary(context),
              ),
              const SizedBox(width: 6),
              'No account needed. Turn on reminders later.'.toText(
                color: AppColors.secondaryText
              )
            ],
          ),
       
          const SizedBox(height: 80), // space for footer
        ],
      ),
    );
  }
}
