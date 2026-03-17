import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/utils/extensions.dart';

import '../../../../core/theme/colors.dart';


/// Styled dropdown for language selection with an overlay options list.
class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Trigger ────────────────────────────────────────────────────────
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 1.2.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               widget.selected.toText(
                fontSize: 16,
                fontWeight: FontWeight.w400
               )
               ,
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
        ),

        // ── Options list ───────────────────────────────────────────────────
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState:
              _open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.border, width: 1.2.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.options.map((option) {
                final isSelected = option == widget.selected;
                return InkWell(
                  onTap: () {
                    widget.onSelected(option);
                    setState(() => _open = false);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child:option.toText(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          )
                        ),
                        if (isSelected)
                          const Icon(Icons.check_rounded,
                              size: 18, color: AppColors.primaryGreen),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}


/// A labelled toggle row used in the "Reminders" section of Step 4.
class ReminderToggleRow extends StatelessWidget {
  const ReminderToggleRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          label.toText(
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
          _TaxLightSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Custom pill switch that matches the design's muted off / green on style.
class _TaxLightSwitch extends StatelessWidget {
  const _TaxLightSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 48.sp,
        height: 28.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: value
              ? AppColors.primaryGreen
              : AppColors.border,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              width: 22.sp,
              height: 22.sp,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}