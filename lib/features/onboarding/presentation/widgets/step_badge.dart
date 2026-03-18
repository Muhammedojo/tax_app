import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show REdgeInsets;
import 'package:tax_app/core/utils/extensions.dart';

import '../../../../core/theme/colors.dart';


/// Small pill badge showing "Step X of Y"
class StepBadge extends StatelessWidget {
  const StepBadge({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  REdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.brandColor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(20),
      ),
      child:  'Step $current of $total'.toText(
        color: AppColors.primaryGreen
      )
    );
  }
}