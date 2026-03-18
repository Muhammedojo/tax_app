import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tax_app/core/navigation/route_constant.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import 'package:tax_app/features/onboarding/presentation/widgets/step_badge.dart';
import '../../../../core/utils/enums.dart';
import '../contract/onboard_contract.dart';
import '../widgets/feature_widget.dart';
import '../widgets/general_scaffold.dart';
import '../widgets/language_dropdown.dart';
import '../widgets/role_card.dart';
import '../widgets/tax_button.dart';
import '../widgets/tax_logo.dart';
import '../widgets/topic_chip.dart';

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
        },
      ),
    );
  }
}

Widget _body(int value, OnboardControllerContract controller) {
  switch (value) {
    case 1:
      return Step1(controller: controller);
    case 2:
      return Step2(controller: controller);
    case 3:
      return Step3(controller: controller);
    case 4:
      return Step4(controller: controller);
    case 5:
      return Step5(controller: controller);
    default:
      return Step1(controller: controller);
  }
}

class Step2 extends StatelessWidget {
  const Step2({super.key, required this.controller});

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
              textHeight: 34 / 28,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            24.verticalSpace,
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
              icon: 'assets/vectors/business.svg',
              title: 'Small Business',
              subtitle: 'SME tax compliance and planning',
              isSelected: value == UserRole.smallBusiness,
              onTap: () => controller.onRoleSelected(UserRole.smallBusiness),
            ),

            const SizedBox(height: 12),

            RoleCard(
              icon: 'assets/vectors/advisor.svg',
              title: 'Advisor/Accountant',
              subtitle: 'Supporting multiple clients',
              isSelected: value == UserRole.advisorAccountant,
              onTap: () =>
                  controller.onRoleSelected(UserRole.advisorAccountant),
            ),
            46.verticalSpace,

            TaxLightButton(
              label: 'Continue',
              onPressed: () {
                controller.currentIndex.value = 3;
              },
            ),

            const SizedBox(height: 12),

            TaxLightButton(
              label: 'Skip for now',
              onPressed: () {},
              variant: TaxLightButtonVariant.ghost,
            ),
          ],
        );
      },
    );
  }
}

class Step1 extends StatelessWidget {
  const Step1({super.key, required this.controller});

  final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBadge(current: 1, total: 5),
        24.verticalSpace,

        "Understand, check, \n and ask - fast.".toText(
          textHeight: 34 / 28,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        24.verticalSpace,
        const FeatureListItem(
          icon: 'assets/vectors/info_icon.svg',
          title: 'Tax Calculator',
          subtitle: 'Check VAT, CIT, PAYE and more in minutes.',
        ),

        const FeatureListItem(
          icon: 'assets/vectors/icon_check.svg',
          title: 'Ask Me',
          subtitle: 'Ask any tax question. Get simple answers.',
        ),

        const FeatureListItem(
          icon: 'assets/vectors/icon_check.svg',
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
          onPressed: () {
            controller.currentIndex.value = 2;
          },
        ),

         SizedBox(height: 12.h),

        TaxLightButton(
          label: 'Skip for now',
          onPressed: () {},
          variant: TaxLightButtonVariant.ghost,
        ),
      ],
    );
  }
}

class Step3 extends StatelessWidget {
  const Step3({super.key, required this.controller});

  final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBadge(current: 3, total: 5),
        24.verticalSpace,

        "Pick your topics.".toText(
          textHeight: 34 / 28,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        6.verticalSpace,

        "You can add more anytime".toText(
          color: AppColors.secondaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        24.verticalSpace,

        ValueListenableBuilder(
          valueListenable: controller.selectedTopics,
          builder: (context, value, child) {
            return Wrap(
              spacing: 10.sp,
              runSpacing: 10.sp,
              children: controller.allTopics.map((topic) {
                return TopicChip(
                  label: topic,
                  isSelected: value.contains(topic),
                  onTap: () => controller.addTopic(topic),
                );
              }).toList(),
            );
          }
        ),
        108.verticalSpace,
        TaxLightButton(
          label: 'Continue',
          onPressed: () {
            controller.currentIndex.value = 4;
          },
        ),

    12.verticalSpace,


        TaxLightButton(
          label: 'Skip for now',
          onPressed: () {},
          variant: TaxLightButtonVariant.ghost,
        ),
      ],
    );
  }
}

class Step4 extends StatelessWidget {
  const Step4({super.key, required this.controller});

  final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepBadge(current: 4, total: 5),
          24.verticalSpace,
      
          "Make it easy for you".toText(
            textHeight: 34 / 28,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          24.verticalSpace,
      
          // Language section
          'Language'.toText(fontSize: 14, fontWeight: FontWeight.w400),
          8.verticalSpace,
          ValueListenableBuilder(
            valueListenable: controller.selectedLanguage,
            builder: (context, value, child) {
              return LanguageDropdown(
                options: controller.languages,
                selected: value,
                onSelected: (lang) => controller.onLanguageSelected(lang),
              );
            },
          ),
      
          24.verticalSpace,
      
          // Reminders section
          'Reminders'.toText(fontSize: 16, fontWeight: FontWeight.w600),
            8.verticalSpace,
      
          ValueListenableBuilder(
            valueListenable: controller.keyDates,
            builder: (context, value, child) {
              return ReminderToggleRow(
                label: 'Key dates & deadlines',
                value: value,
                onChanged: (v) => controller.setKeyDates(),
              );
            },
          ),
      
          10.verticalSpace,
      
          ValueListenableBuilder(
            valueListenable: controller.newCirculars,
            builder: (context, value, child) {
              return ReminderToggleRow(
                label: 'New circulars & updates',
                value: value,
                onChanged: (v) => controller.setNewCirculars(),
              );
            },
          ),
      
          10.verticalSpace,
      
          ValueListenableBuilder(
            valueListenable: controller.monthlySummary,
            builder: (context, value, child) {
              return ReminderToggleRow(
                label: 'Monthly summary',
                value: value,
                onChanged: (v) => controller.setMonthlySummary(),
              );
            },
          ),
      
          12.verticalSpace,
      
          // Disclaimer note
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 20.sp,
                color: AppColors.secondaryText,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: "We'll only notify you about the topics you choose."
                    .toText(color: AppColors.secondaryText, fontSize: 12),
              ),
            ],
          ),

          17.verticalSpace,
      
          TaxLightButton(
            label: 'Continue',
            onPressed: () {
              controller.currentIndex.value = 5;
            },
          ),
      
          12.verticalSpace,
      
          TaxLightButton(
            label: 'Skip for now',
            onPressed: () {
             
            },
            variant: TaxLightButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

class Step5 extends StatelessWidget {
  const Step5({super.key, required this.controller});

  final OnboardControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepBadge(current: 5, total: 5),
        24.verticalSpace,

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           'protect'.toSvg(
                  width: 44.2.sp,
                  height: 48.sp,
                ),
           12.horizontalSpace,
            Expanded(
              child: 'Your data, kept minimal'.toText(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

       24.verticalSpace,

        'We store your role and topics so we can personalise your summaries.'
            .toText(
              color: AppColors.secondaryText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),

    12.verticalSpace,

        'You can turn off reminders anytime.'.toText(
          color: AppColors.secondaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),

       20.verticalSpace,

        // Privacy Policy + Terms links
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Privacy Policy ',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                  color: AppColors.primaryGreen,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryGreen,
                ),
                recognizer: TapGestureRecognizer()..onTap = (){},
              ),
              WidgetSpan(
                child: Icon(
                  Icons.open_in_new_rounded,
                  size: 16.sp,
                  color: AppColors.primaryGreen,
                ),
              ),
              const TextSpan(text: '   '),
              TextSpan(
                text: 'Terms ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                        fontFamily: 'Nunito',
                  color: AppColors.primaryGreen,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryGreen,
                ),
                recognizer: TapGestureRecognizer()..onTap = (){},
              ),
              WidgetSpan(
                child: Icon(
                  Icons.open_in_new_rounded,
                  size: 16.sp,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),

        45.verticalSpace,

        TaxLightButton(
          label: 'Agree & sort',
          onPressed: () {
            controller.goToOffline();
          },
        ),

        12.verticalSpace,

        TaxLightButton(
          label: 'Read full policy',
          onPressed: () {},
          variant: TaxLightButtonVariant.ghost,
        ),
      ],
    );
  }
}
