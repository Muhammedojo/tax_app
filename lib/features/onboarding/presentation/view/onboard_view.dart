import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tax_app/core/utils/extensions.dart';
import 'package:tax_app/features/onboarding/presentation/widgets/step_badge.dart';
import '../../../../core/utils/enums.dart';
import '../contract/onboard_contract.dart';
import '../widgets/feature_widget.dart';
import '../widgets/general_scaffold.dart';
import '../widgets/role_card.dart';
import '../widgets/tax_button.dart';
import '../widgets/tax_logo.dart';

class OnboardView extends StatelessWidget implements OnboardViewContract {
  const OnboardView({super.key, required this.controller});

  final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
     return TaxLightScaffold(
      showTopActions: true,
      body: ValueListenableBuilder(
        valueListenable: controller.currentIndex,
        builder: (context, value, child) {
          return _body(value, controller);
        }
      )
      
    );
  }
}

Widget _body(int value, OnboardControllerContract controller){
           switch (value) {
            case 1:
              return Step1(controller: controller,);
            default:
              return Step2(controller: controller);
          }
}

class Step2 extends StatelessWidget {
  const Step2({
    super.key,
    required this.controller,
  });

  final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedRole,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                    StepBadge(current: 2, total: 5),
          24.verticalSpace,
               "Who are you here as?".toText(
            textHeight: 34/28,
            fontSize: 28,
            fontWeight: FontWeight.w700
          ),24.verticalSpace,
            // Role cards
              RoleCard(
                icon: 'assets/vectors/person.svg',
                title: 'Individual',
                subtitle: 'Personal tax matters and obligations',
                isSelected: value == UserRole.individual,
                onTap: () => controller.onRoleSelected(UserRole.individual),
              ),
         
              const SizedBox(height: 12),
         
              RoleCard(
                icon:  'assets/vectors/business.svg',
                title: 'Small Business',
                subtitle: 'SME tax compliance and planning',
                isSelected: value == UserRole.smallBusiness,
                onTap: () => controller.onRoleSelected(UserRole.smallBusiness),
              ),
         
              const SizedBox(height: 12),
         
              RoleCard(
                icon:  'assets/vectors/advisor.svg',
                title: 'Advisor/Accountant',
                subtitle: 'Supporting multiple clients',
                isSelected: value == UserRole.advisorAccountant,
                onTap: () =>
                    controller.onRoleSelected(UserRole.advisorAccountant),
              ),
                 46.verticalSpace,
        
          TaxLightButton(
          label: 'Continue',
          onPressed: (){
            controller.currentIndex.value = 3;
          },
        ),
         
        const SizedBox(height: 12),
         
        TaxLightButton(
          label: 'Skip for now',
          onPressed: (){},
          variant: TaxLightButtonVariant.ghost,
        ),
         
          ],
        );
      }
    );
  }
}

class Step1 extends StatelessWidget {
  const Step1({
    super.key,required this.controller
  });

 final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBadge(current: 1, total: 5),
        24.verticalSpace,
    
        "Understand, check, \n and ask - fast.".toText(
          textHeight: 34/28,
          fontSize: 28,
          fontWeight: FontWeight.w700
        ),24.verticalSpace,
          const FeatureListItem(
            icon: 'assets/vectors/info_icon.svg',
            title: 'Tax Calculator',
            subtitle: 'Check VAT, CIT, PAYE and more in minutes.',
    
          ),
     
          const FeatureListItem(
            icon:  'assets/vectors/icon_check.svg',
            title: 'Ask Me',
            subtitle: 'Ask any tax question. Get simple answers.',
          ),
    
          const FeatureListItem(
            icon:  'assets/vectors/icon_check.svg',
            title: 'Tax Law Checker',
            subtitle: 'Search clauses. Read them in plain English.',
    
          ),
    
     
          const FeatureListItem(
            icon: 'assets/vectors/icon_doc.svg',
            title: 'Updates & Learn',
            subtitle: 'Plain-English changes and deadlines.',
    
          ),
          26.verticalSpace,
    
            TaxLightButton(
            label: 'Continue',
            onPressed: (){
              controller.currentIndex.value = 2;
            },
          ),
     
          const SizedBox(height: 12),
     
          TaxLightButton(
            label: 'Skip for now',
            onPressed: (){},
            variant: TaxLightButtonVariant.ghost,
          ),
    
      ],
    );
  }
}
