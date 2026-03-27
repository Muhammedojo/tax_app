import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/data/model/update.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../bloc/update/update_cubit.dart';
import '../contract/update.dart';

class UpdateView extends StatelessWidget implements UpdateViewContract {
  const UpdateView({super.key, required this.controller});

  final UpdateControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: false,
      title: 'Updates',
      showLogo: false,
      body: BlocBuilder<UpdateCubit, UpdateState>(
        builder: (context, state) {
          return switch (state) {
            UpdateLoading() => const Center(child: CircularProgressIndicator()),
            UpdateLoaded(:final updateList) => ListView(
              padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
              children: [
                const _BannerCard(),
                20.verticalSpace,
                ...updateList.map(
                  (u) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: _UpdateCard(update: u),
                  ),
                ),
              ],
            ),
            UpdateFailure(:final error) => Center(child: Text(error)),
            _ => const SizedBox.shrink(),
          };
        },
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

  final Update update;

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
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: (update.topic ?? '').toText(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  translate: false,
                ),
              ),
              12.horizontalSpace,
              (update.publishedAt ?? '').toText(
                fontSize: 13,
                color: AppColors.secondaryText,
                translate: false,
              ),
            ],
          ),
          12.verticalSpace,
          (update.title ?? '').toText(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            translate: false,
          ),
          16.verticalSpace,
          _InfoRow(
            icon: Icons.info_outlined,
            label: 'What it means',
            body: update.summary ?? '',
          ),

          12.verticalSpace,
          _InfoRow(
            icon: Icons.description_outlined,
            label: 'status',
            body: update.status ?? '',
          ),
          // 12.verticalSpace,
          // _InfoRow(
          //   icon: Icons.check_circle_outline,
          //   label: 'What to do',
          //   body: update.whatToDo,
          // ),
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
  const _InfoRow({required this.icon, required this.label, required this.body});

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
