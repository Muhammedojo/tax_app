import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/calculator_contract.dart';

// ─── Tax result model ────────────────────────────────────────────────────────

class _TaxResult {
  const _TaxResult({required this.gross, required this.paye});
  final double gross;
  final double paye;
  double get takeHome => gross - paye;
}

// ─── PITA band helper ────────────────────────────────────────────────────────

double _applyBands(double taxable, List<(double, double)> bands) {
  double tax = 0;
  double remaining = taxable;
  for (final (limit, rate) in bands) {
    if (remaining <= 0) break;
    final chunk = remaining < limit ? remaining : limit;
    tax += chunk * rate;
    remaining -= chunk;
  }
  if (remaining > 0) tax += remaining * 0.24;
  return tax;
}

// ─── 2025 calculation (current PITA) ────────────────────────────────────────

_TaxResult _calculate2025(double monthlyGross) {
  final annual = monthlyGross * 12;
  final craBase = annual * 0.01 > 200000 ? annual * 0.01 : 200000.0;
  final cra = craBase + annual * 0.20;
  final taxable = (annual - cra) < 0 ? 0.0 : annual - cra;
  const bands = [
    (300000.0, 0.07),
    (300000.0, 0.11),
    (500000.0, 0.15),
    (500000.0, 0.19),
    (1600000.0, 0.21),
  ];
  final progressiveTax = _applyBands(taxable, bands);
  final minimumTax = annual * 0.01;
  final annualPaye = progressiveTax > minimumTax ? progressiveTax : minimumTax;
  return _TaxResult(gross: monthlyGross, paye: annualPaye / 12);
}

// ─── 2026 calculation (reported new rules) ───────────────────────────────────

_TaxResult _calculate2026(double monthlyGross) {
  final annual = monthlyGross * 12;
  final craBase = annual * 0.01 > 200000 ? annual * 0.01 : 200000.0;
  // Reported: rent relief of ₦800k added to CRA
  final cra = craBase + annual * 0.20 + 800000;
  final taxable = (annual - cra) < 0 ? 0.0 : annual - cra;
  // Reported revised bands: lower rates on first tiers
  const bands = [
    (500000.0, 0.05),
    (500000.0, 0.10),
    (500000.0, 0.15),
    (500000.0, 0.19),
    (1600000.0, 0.21),
  ];
  final tax = _applyBands(taxable, bands);
  final minimumTax = annual * 0.01;
  final annualPaye = tax > minimumTax ? tax : minimumTax;
  return _TaxResult(gross: monthlyGross, paye: annualPaye / 12);
}

// ─── View ────────────────────────────────────────────────────────────────────

class CalculatorView extends StatelessWidget implements CalculatorViewContract {
  const CalculatorView({super.key, required this.controller});

  final CalculatorControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final gross = controller.monthlyGross;
    final result2025 = gross != null ? _calculate2025(gross) : null;
    final result2026 = gross != null ? _calculate2026(gross) : null;
    final hasValue = controller.salaryController.text.trim().isNotEmpty;

    return TaxLightScaffold(
      showTopActions: false,
      title: 'Quick Check',
      showLogo: false,
      body: ListView(
        padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
        children: [
          _InputCard(
            controller: controller.salaryController,
            hasValue: hasValue,
            onCalculate: controller.calculate,
          ),
          if (controller.hasCalculated && result2025 != null) ...[
            24.verticalSpace,
            _TabBar(
              selectedIndex: controller.selectedTab,
              onSelect: controller.selectTab,
            ),
            16.verticalSpace,
            controller.selectedTab == 0
                ? _ResultCard(result: result2025, isNewRules: false)
                : _ResultCard(result: result2026!, isNewRules: true),
            16.verticalSpace,
            const _ShareButton(),
          ],
        ],
      ),
    );
  }
}

// ─── Input card ───────────────────────────────────────────────────────────────

class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.controller,
    required this.hasValue,
    required this.onCalculate,
  });

  final TextEditingController controller;
  final bool hasValue;
  final VoidCallback onCalculate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Your monthly salary'.toText(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            translate: false,
          ),
          10.verticalSpace,
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff0A0D14),
            ),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: REdgeInsets.only(left: 14, right: 8, top: 14, bottom: 14),
                child: '₦'.toText(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                  translate: false,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              hintText: '100,000',
              hintStyle: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16.sp,
                color: AppColors.subText,
              ),
              contentPadding: REdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: AppColors.primaryGreen),
              ),
            ),
          ),
          8.verticalSpace,
          'Enter your gross monthly salary before deductions'.toText(
            fontSize: 12,
            color: AppColors.subText,
            translate: false,
          ),
          16.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: hasValue ? onCalculate : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                disabledBackgroundColor:
                    AppColors.primaryGreen.withValues(alpha: 0.45),
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              child: 'Calculate'.toText(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                translate: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab bar ──────────────────────────────────────────────────────────────────

class _TabBar extends StatelessWidget {
  const _TabBar({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Tab(
          label: 'Today (2025)',
          selected: selectedIndex == 0,
          onTap: () => onSelect(0),
        ),
        32.horizontalSpace,
        _Tab(
          label: 'New Rules (2026)',
          selected: selectedIndex == 1,
          onTap: () => onSelect(1),
        ),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          label.toText(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color:
                selected ? AppColors.primaryGreen : AppColors.secondaryText,
            translate: false,
          ),
          6.verticalSpace,
          Container(
            height: 2,
            width: label.length * 7.5.w,
            decoration: BoxDecoration(
              color: selected ? AppColors.primaryGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Result card ──────────────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.isNewRules});

  final _TaxResult result;
  final bool isNewRules;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              'Take-home'.toText(
                fontSize: 14,
                color: AppColors.secondaryText,
                translate: false,
              ),
              const Spacer(),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isNewRules ? AppColors.bgYellow : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: (isNewRules ? 'Reported/Pending' : 'Confirmed').toText(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isNewRules ? AppColors.brown : AppColors.primaryGreen,
                  translate: false,
                ),
              ),
            ],
          ),
          8.verticalSpace,
          result.takeHome.currencyFormat().toText(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryGreen,
            translate: false,
          ),
          16.verticalSpace,
          _BreakdownRow(
            label: 'Gross salary',
            value: result.gross.currencyFormat(),
            valueColor: const Color(0xff0A0D14),
          ),
          10.verticalSpace,
          _BreakdownRow(
            label: isNewRules ? 'PAYE tax (new)' : 'PAYE tax',
            value: '- ${result.paye.currencyFormat()}',
            valueColor: AppColors.primaryRed,
          ),
          16.verticalSpace,
          _InfoBox(isNewRules: isNewRules),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        label.toText(
          fontSize: 13,
          color: AppColors.secondaryText,
          translate: false,
        ),
        value.toText(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: valueColor,
          translate: false,
        ),
      ],
    );
  }
}

// ─── Info box ─────────────────────────────────────────────────────────────────

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.isNewRules});

  final bool isNewRules;

  @override
  Widget build(BuildContext context) {
    final bgColor = isNewRules ? AppColors.bgYellow : AppColors.lightGreen;
    final iconColor = isNewRules ? AppColors.brown : AppColors.primaryGreen;
    final message = isNewRules
        ? 'Based on reported new PIT bands and rent relief. Awaiting official gazette/regulations.'
        : 'Based on current PITA bands and CRA + minimum tax rule.';
    final link =
        isNewRules ? 'Read about the changes →' : 'See calculation details →';

    return Container(
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outlined, size: 16.sp, color: iconColor),
              8.horizontalSpace,
              Expanded(
                child: message.toText(fontSize: 13, translate: false),
              ),
            ],
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: link.toText(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: iconColor,
              translate: false,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Share button ─────────────────────────────────────────────────────────────

class _ShareButton extends StatelessWidget {
  const _ShareButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: 'Share via WhatsApp'.toText(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          translate: false,
        ),
      ),
    );
  }
}
