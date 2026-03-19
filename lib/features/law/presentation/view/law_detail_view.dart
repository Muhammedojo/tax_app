import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/law_detail_contract.dart';

class LawSection {
  final String lawName;
  final String sectionTitle;
  final String heading;
  final String effectiveDate;
  final String sectionText;
  final bool isInForce;
  final bool isOffline;

  const LawSection({
    required this.lawName,
    required this.sectionTitle,
    required this.heading,
    required this.effectiveDate,
    required this.sectionText,
    this.isInForce = true,
    this.isOffline = true,
  });
}

class LawDetailView extends StatelessWidget implements LawDetailViewContract {
  const LawDetailView({
    super.key,
    required this.controller,
    required this.section,
  });

  final LawDetailControllerContract controller;
  final LawSection section;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: false,
      customTitle: true,
      widgetTitle: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              section.lawName.toText(
                fontSize: 12,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w500,
                textHeight: 0,
                translate: false,
              ),

              section.sectionTitle.toText(
                fontSize: 18,
                textHeight: 0,
                fontWeight: FontWeight.w700,
                translate: false,
              ),
            ],
          ),
        ],
      ),
      showLogo: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
              //  padding: REdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.verticalSpace,
                    Row(
                      children: [
                        if (section.isInForce)
                          Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: 'In Force'.toText(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryGreen,
                              translate: false,
                            ),
                          ),
                        if (section.isInForce && section.isOffline)
                          12.horizontalSpace,
                        if (section.isOffline)
                          Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download_outlined,
                                  size: 14.sp,
                                  color: AppColors.secondaryText,
                                ),
                                4.horizontalSpace,
                                'Offline'.toText(
                                  fontSize: 13,
                                  color: AppColors.secondaryText,
                                  translate: false,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    24.verticalSpace,
                    Container(
                      width: double.infinity,
                      padding: REdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          section.heading.toText(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            translate: false,
                          ),
                          8.verticalSpace,
                          'Effective from ${section.effectiveDate}'.toText(
                            fontSize: 13,
                            color: AppColors.secondaryText,
                            translate: false,
                          ),
                          20.verticalSpace,
                          'Section Text'.toText(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            translate: false,
                          ),
                          12.verticalSpace,
                          section.sectionText.toText(
                            fontSize: 15,
                            textHeight: 24 / 15,
                            translate: false,
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
