import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../contract/settings_contract.dart';
import '../widgets/general_scaffold.dart';
import '../widgets/tax_button.dart';
import '../widgets/topic_chip.dart';
import '../widgets/language_dropdown.dart';

class SettingsView extends StatelessWidget implements SettingsViewContract {
  const SettingsView({super.key, required this.controller});

  final SettingsControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      title: 'Settings',
      showTopActions: false,
      body: ListView(
        padding: EdgeInsets.only(top: 24.h),
        children: [
          // ── Language ───────────────────────────────────────────────────────
          _sectionLabel('Language'),
          8.verticalSpace,
          _SettingsRow(
            leading: Icon(
              Icons.language_rounded,
              color: AppColors.secondaryText,
              size: 20.sp,
            ),
            label: controller.selectedLanguage,
            onTap: () => _showLanguageSheet(context),
          ),
          24.verticalSpace,

          // ── Your Role ──────────────────────────────────────────────────────
          _sectionLabel('Your Role'),
          8.verticalSpace,
          _SettingsRow(
            label: controller.selectedRole,
            onTap: () => _showRoleSheet(context),
          ),
          24.verticalSpace,

          // ── Your Topics ────────────────────────────────────────────────────
          _sectionLabel('Your Topics'),
          8.verticalSpace,
          _SettingsRow(
            label: '${controller.selectedTopics.length} topics selected',
            onTap: () => _showTopicsSheet(context),
          ),
          24.verticalSpace,

          // ── Reminders ──────────────────────────────────────────────────────
          _sectionLabel('Reminders'),
          8.verticalSpace,
          _RemindersCard(controller: controller),
          24.verticalSpace,

          // ── Privacy & Legal ────────────────────────────────────────────────
          _sectionLabel('Privacy & Legal'),
          8.verticalSpace,
          _SettingsRow(label: 'Privacy Policy & Terms', onTap: () {}),
          80.verticalSpace,
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) => text.toText(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.subText,
        translate: false,
      );

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _SelectListSheet(
        title: 'Select Language',
        options: controller.languages,
        selected: controller.selectedLanguage,
        onSelect: (val) {
          controller.selectLanguage(val);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showRoleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _SelectListSheet(
        title: 'Select Your Role',
        options: controller.roles,
        selected: controller.selectedRole,
        onSelect: (val) {
          controller.selectRole(val);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showTopicsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _TopicsSheet(
        controller: controller,
        onDone: () => Navigator.pop(context),
      ),
    );
  }
}

// ─── Settings row ─────────────────────────────────────────────────────────────

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.label,
    required this.onTap,
    this.leading,
  });

  final String label;
  final VoidCallback onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            if (leading != null) ...[leading!, 12.horizontalSpace],
            Expanded(
              child: label.toText(fontSize: 16, translate: false),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.secondaryText,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reminders card ───────────────────────────────────────────────────────────

class _RemindersCard extends StatelessWidget {
  const _RemindersCard({required this.controller});

  final SettingsControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          ReminderToggleRow(
            label: 'Key dates & deadlines',
            value: controller.keyDates,
            onChanged: (_) => controller.toggleKeyDates(),
          ),
          Divider(height: 1, color: AppColors.border),
          ReminderToggleRow(
            label: 'New circulars & updates',
            value: controller.newCirculars,
            onChanged: (_) => controller.toggleNewCirculars(),
          ),
          Divider(height: 1, color: AppColors.border),
          ReminderToggleRow(
            label: 'Monthly summary',
            value: controller.monthlySummary,
            onChanged: (_) => controller.toggleMonthlySummary(),
          ),
        ],
      ),
    );
  }
}

// ─── Select list sheet ────────────────────────────────────────────────────────

class _SelectListSheet extends StatelessWidget {
  const _SelectListSheet({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            20.verticalSpace,
            title.toText(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              translate: false,
            ),
            16.verticalSpace,
            ...options.map((opt) {
              final isSelected = opt == selected;
              return GestureDetector(
                onTap: () => onSelect(opt),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryGreen
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.border,
                    ),
                  ),
                  child: opt.toText(
                    fontSize: 16,
                    color: isSelected ? AppColors.white : null,
                    translate: false,
                  ),
                ),
              );
            }),
            8.verticalSpace,
          ],
        ),
      ),
    );
  }
}

// ─── Topics sheet ─────────────────────────────────────────────────────────────

class _TopicsSheet extends StatelessWidget {
  const _TopicsSheet({
    required this.controller,
    required this.onDone,
  });

  final SettingsControllerContract controller;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: REdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            20.verticalSpace,
            Center(
              child: 'Select Topics'.toText(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                translate: false,
              ),
            ),
            20.verticalSpace,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.allTopics.map((t) {
                return TopicChip(
                  label: t,
                  isSelected: controller.selectedTopics.contains(t),
                  onTap: () => controller.toggleTopic(t),
                );
              }).toList(),
            ),
            24.verticalSpace,
            TaxLightButton(label: 'Done', onPressed: onDone),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
