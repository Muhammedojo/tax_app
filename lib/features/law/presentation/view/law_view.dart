import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/navigation/navigator.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/law_contract.dart';
import '../controller/law_detail_controller.dart';
import 'law_detail_view.dart';

class _TaxLaw {
  final String name;
  final bool isOffline;

  const _TaxLaw({required this.name, required this.isOffline});
}

const _laws = [
  _TaxLaw(name: 'PITA', isOffline: true),
  _TaxLaw(name: 'VAT Act', isOffline: true),
  _TaxLaw(name: 'Finance Act', isOffline: true),
  _TaxLaw(name: 'CITA', isOffline: true),
];

const _filters = ['All Laws', 'PITA', 'VAT Act', 'Finance Act', 'CITA'];

const _recentSearches = ['minimum tax', 'VAT exemptions'];

const _sectionsByLaw = <String, LawSection>{
  'PITA': LawSection(
    lawName: 'Personal Income Tax Act (PITA)',
    sectionTitle: 'Section 3(1)',
    heading: 'Persons Chargeable',
    effectiveDate: '1 January 2011',
    sectionText:
        'Tax shall be payable for each year of assessment on the income of any person accruing in, derived from, brought into, or received in Nigeria in respect of—\n\n'
        '(a) gains or profits from any trade, business, profession or vocation for whatever period of time such trade, business, profession or vocation may have been carried on or exercised;\n\n'
        '(b) salary, wages, fees, allowances or other gains or profits from employment including compensations, bonuses, premiums, benefits or other perquisites allowed, given or granted by or on behalf of an employer to an employee, other than those allowed, given or granted under any law.',
  ),
  'VAT Act': LawSection(
    lawName: 'Value Added Tax Act (VAT)',
    sectionTitle: 'Section 1(1)',
    heading: 'Imposition of Tax',
    effectiveDate: '1 January 1994',
    sectionText:
        'There is hereby imposed and charged a tax to be known as the Value Added Tax (in this Act referred to as "the tax") which shall be administered in accordance with the provisions of this Act.\n\n'
        'The tax shall be charged and payable on the supply of all goods and services (other than those listed in the First Schedule to this Act) made by a taxable person.\n\n'
        'The rate of the tax shall be 7.5 percent on the value of the goods and services as determined under this Act.',
  ),
  'Finance Act': LawSection(
    lawName: 'Finance Act',
    sectionTitle: 'Section 2(1)',
    heading: 'Tax Reliefs and Exemptions',
    effectiveDate: '13 January 2020',
    sectionText:
        'The provisions of the Finance Act shall apply to taxes administered by the Federal Inland Revenue Service and shall amend the relevant tax laws accordingly.\n\n'
        'Notwithstanding anything to the contrary in any other law, any person whose gross income for a year of assessment does not exceed the minimum wage applicable at the federal level shall not be liable to income tax for that year.\n\n'
        'The reliefs and allowances available to individual taxpayers shall be reviewed periodically by the relevant authority to reflect changes in economic conditions.',
  ),
  'CITA': LawSection(
    lawName: 'Companies Income Tax Act (CITA)',
    sectionTitle: 'Section 9(1)',
    heading: 'Charge of Tax',
    effectiveDate: '1 April 1977',
    sectionText:
        'Tax shall be payable for each year of assessment on the profits of any company accruing in, derived from, brought into, or received in Nigeria in respect of—\n\n'
        '(a) any trade or business for whatever period of time such trade or business may have been carried on;\n\n'
        '(b) rent or any premium arising from a right granted to any other person for the use or occupation of any property;\n\n'
        '(c) dividends, interests, royalties, discounts, charges or annuities.',
  ),
};

class LawView extends StatelessWidget implements LawViewContract {
  const LawView({super.key, required this.controller});

  final LawControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: false,
      title: 'Tax Law Checker',
      showLogo: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          _SearchBar(),
          14.verticalSpace,
          _FilterChips(
            filters: _filters,
            selected: controller.selectedFilter,
            onSelect: controller.selectFilter,
          ),
          14.verticalSpace,
          _StatusBanner(),
          20.verticalSpace,
          'Browse by Law'.toText(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            translate: false,
          ),
          12.verticalSpace,
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 24.h),
              children: [
                ..._filteredLaws(controller.selectedFilter).map(
                  (law) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _LawItem(
                      law: law,
                      onTap: () => pushTo(
                        LawDetailScreen(
                          section: _sectionsByLaw[law.name] ??
                              _sectionsByLaw['PITA']!,
                        ),
                        context,
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                'Recent Searches'.toText(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  translate: false,
                ),
                12.verticalSpace,
                ..._recentSearches.map(
                  (s) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _RecentSearchItem(text: s),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_TaxLaw> _filteredLaws(String filter) {
    if (filter == 'All Laws') return _laws;
    return _laws.where((l) => l.name == filter).toList();
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          12.horizontalSpace,
          Icon(Icons.search, color: AppColors.secondaryText, size: 20.sp),
          10.horizontalSpace,
          'Search tax laws...'.toText(
            fontSize: 14,
            color: AppColors.subText,
            translate: false,
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.filters,
    required this.selected,
    required this.onSelect,
  });

  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, i) => 8.horizontalSpace,
        itemBuilder: (_, i) {
          final isSelected = filters[i] == selected;
          return GestureDetector(
            onTap: () => onSelect(filters[i]),
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen : AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryGreen
                      : AppColors.border,
                ),
              ),
              child: filters[i].toText(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.secondaryText,
                translate: false,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 10.r,
            height: 10.r,
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'All laws downloaded'.toText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                translate: false,
              ),
              4.verticalSpace,
              'You can search and read offline anytime'.toText(
                fontSize: 12,
                color: AppColors.secondaryText,
                translate: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LawItem extends StatelessWidget {
  const _LawItem({required this.law, required this.onTap});

  final _TaxLaw law;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(Icons.menu_book_outlined,
                color: AppColors.primaryGreen, size: 22.sp),
            12.horizontalSpace,
            Expanded(
              child: law.name.toText(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                translate: false,
              ),
            ),
            if (law.isOffline)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  6.horizontalSpace,
                  'Offline'.toText(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                    translate: false,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _RecentSearchItem extends StatelessWidget {
  const _RecentSearchItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.secondaryText, size: 18.sp),
          12.horizontalSpace,
          text.toText(
            fontSize: 14,
            color: AppColors.secondaryText,
            translate: false,
          ),
        ],
      ),
    );
  }
}
