import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../../../../core/theme/colors.dart';


enum TaxLightButtonVariant { primary, ghost }

/// Elevated pill-shaped button matching the TaxLight design.
///
/// [variant] controls whether it renders as the solid green primary button
/// or the ghost (transparent with green text) secondary button.
class TaxLightButton extends StatelessWidget {
  const TaxLightButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = TaxLightButtonVariant.primary,
    this.isFullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final TaxLightButtonVariant variant;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == TaxLightButtonVariant.primary;

    final child = SizedBox(
      height: 59.sp,
      width: isFullWidth ? double.infinity : null,
      child: isPrimary
          ? _PrimaryButton(label: label, onPressed: onPressed)
          : _GhostButton(label: label, onPressed: onPressed),
    );

    return child;
  }
}

// ---------------------------------------------------------------------------
// Primary — solid green with bottom shadow elevation
// ---------------------------------------------------------------------------

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandColor.withAlpha((0.35 * 225).toInt()),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.brandColor.withAlpha((0.15 * 225).toInt()),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandColor,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primaryGreen.withAlpha((0.5 * 225).toInt()),
          elevation: 10, // shadow handled by BoxDecoration
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          minimumSize: const Size(double.infinity, 54),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: label.toText(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,color: AppColors.white
        )
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Ghost — transparent background, green label
// ---------------------------------------------------------------------------

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brandColor,
        backgroundColor: AppColors.colorPrimary.withValues(alpha: 0.15),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        minimumSize: const Size(double.infinity, 54),
        padding:  REdgeInsets.symmetric(horizontal: 24),
      ),
      child: label.toText(
        color: AppColors.primaryGreen,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600
      )
    );
  }
}