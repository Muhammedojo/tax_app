import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/update.dart';

class _TaxUpdate {
  final String tag;
  final Color tagColor;
  final String date;
  final String title;
  final String whatChanged;
  final String whatItMeans;
  final String whatToDo;

  const _TaxUpdate({
    required this.tag,
    required this.tagColor,
    required this.date,
    required this.title,
    required this.whatChanged,
    required this.whatItMeans,
    required this.whatToDo,
  });
}

const _updates = [
  _TaxUpdate(
    tag: 'VAT',
    tagColor: AppColors.orange,
    date: '10 Dec 2025',
    title: 'VAT on Essential Items',
    whatChanged:
        'VAT removed from food items, education, healthcare, rent, and electricity (reported changes awaiting official confirmation).',
    whatItMeans:
        'Your grocery bills, school fees, hospital bills, and rent may not include 7.5% VAT anymore—saving you money on essentials.',
    whatToDo:
        "Ask sellers if they've removed VAT from these items. Keep receipts. If charged VAT incorrectly, report to FIRS.",
  ),
  _TaxUpdate(
    tag: 'PAYE',
    tagColor: AppColors.orange,
    date: '15 Dec 2025',
    title: 'PAYE Tax Threshold Increase',
    whatChanged:
        'The minimum taxable income threshold has been raised, reducing the tax burden on lower-income earners.',
    whatItMeans:
        'If you earn below the new threshold, you may pay less income tax or none at all, increasing your take-home pay.',
    whatToDo:
        'Review your payslip to confirm updated PAYE deductions. Contact your HR department if deductions seem incorrect.',
  ),
];

class UpdateView extends StatelessWidget implements UpdateViewContract {
  const UpdateView({super.key, required this.controller});

  final UpdateControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: false,
      title: 'Updates',
      showLogo: false,
      body: ListView(
        padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
        children: [
          const _BannerCard(),
          20.verticalSpace,
          ..._updates.map(
            (u) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _UpdateCard(update: u),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Understanding Tax Changes'.toText(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            translate: false,
          ),
          6.verticalSpace,
          "Learn what's new in Nigerian tax laws".toText(
            fontSize: 14,
            color: AppColors.secondaryText,
            translate: false,
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  const _UpdateCard({required this.update});

  final _TaxUpdate update;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
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
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: update.tagColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: update.tag.toText(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  translate: false,
                ),
              ),
              12.horizontalSpace,
              update.date.toText(
                fontSize: 13,
                color: AppColors.secondaryText,
                translate: false,
              ),
            ],
          ),
          12.verticalSpace,
          update.title.toText(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            translate: false,
          ),
          16.verticalSpace,
          _InfoRow(
            icon: Icons.description_outlined,
            label: 'What changed',
            body: update.whatChanged,
          ),
          12.verticalSpace,
          _InfoRow(
            icon: Icons.info_outlined,
            label: 'What it means',
            body: update.whatItMeans,
          ),
          12.verticalSpace,
          _InfoRow(
            icon: Icons.check_circle_outline,
            label: 'What to do',
            body: update.whatToDo,
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(child: _OutlineButton(label: 'Mark as done')),
              12.horizontalSpace,
              Expanded(child: _OutlineButton(label: 'Save for later')),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.body,
  });

  final IconData icon;
  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: AppColors.primaryGreen),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label.toText(
                fontSize: 13,
                color: AppColors.secondaryText,
                translate: false,
              ),
              4.verticalSpace,
              body.toText(fontSize: 14, translate: false),
            ],
          ),
        ),
      ],
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: REdgeInsets.symmetric(vertical: 12),
      ),
      child: label.toText(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        translate: false,
      ),
    );
  }
}
