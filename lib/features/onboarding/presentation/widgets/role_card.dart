import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../../../../core/theme/colors.dart';

/// Selectable role card used on the "Who are you here as?" screen.
class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen.withValues(alpha: 0.15)
              : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : AppColors.border,
            width: isSelected ? 2.sp : 1.2.sp,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen
                    : AppColors.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: SvgPicture.asset(icon,width: 24.sp, height: 24.sp,color: isSelected ? AppColors.white : Colors.black,))
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 title.toText(
                  fontSize: 16,
                 ),
                  const SizedBox(height: 2),
                 subtitle.toText(
                  color: AppColors.secondaryText,
                  fontSize: 12
                 )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

