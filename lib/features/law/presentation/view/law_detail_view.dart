import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/data/model/offline_pack.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/law_detail_contract.dart';

class LawDetailView extends StatelessWidget implements LawDetailViewContract {
  const LawDetailView({
    super.key,
    required this.controller,
    required this.registry,
    required this.entries,
  });

  final LawDetailControllerContract controller;
  final LawRegistry registry;
  final List<LawEntry> entries;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: false,
      customTitle: true,
      widgetTitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (registry.name ?? '').toText(
            fontSize: 12,
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.w500,
            textHeight: 0,
            translate: false,
          ),
          (registry.shortName ?? '').toText(
            fontSize: 18,
            textHeight: 0,
            fontWeight: FontWeight.w700,
            translate: false,
          ),
        ],
      ),
      showLogo: false,
      body: SafeArea(
        child: entries.isEmpty
            ? Center(
                child: 'No sections available'.toText(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                  translate: false,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.only(top: 12.h, bottom: 32.h),
                itemCount: entries.length,
                separatorBuilder: (_, _) => 12.verticalSpace,
                itemBuilder: (_, i) =>
                    _SectionCard(registry: registry, entry: entries[i]),
              ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.registry, required this.entry});

  final LawRegistry registry;
  final LawEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Container(
                padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              12.horizontalSpace,
              Container(
                padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          (entry.section ?? '').toText(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            translate: false,
          ),
          8.verticalSpace,
          'Effective from ${registry.year ?? 'N/A'}'.toText(
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
          (entry.content ?? '').toText(
            fontSize: 15,
            textHeight: 24 / 15,
            translate: false,
          ),
        ],
      ),
    );
  }
}
