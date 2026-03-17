import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../../../../core/theme/colors.dart';


/// A toggleable chip used on the "Pick your topics" screen.
class TopicChip extends StatelessWidget {
  const TopicChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : AppColors.white,
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : AppColors.border,
            width: 1.5.sp,
          ),
        ),
        child: label.toText(
          color: isSelected ? AppColors.white : AppColors.secondaryText,
          fontSize: 16,
          fontWeight: FontWeight.w400
        )
      ),
    );
  }
}