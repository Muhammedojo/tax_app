import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/data/model/offline_pack.dart';
import 'package:tax_app/core/navigation/navigator.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/bloc/offline_pack/offline_pack_cubit.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/law_contract.dart';
import '../controller/law_detail_controller.dart';

const _recentSearches = ['minimum tax', 'VAT exemptions'];

class LawView extends StatelessWidget implements LawViewContract {
  const LawView({super.key, required this.controller});

  final LawControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return TaxLightScaffold(
      showTopActions: false,
      title: 'Tax Law Checker',
      showLogo: false,
      body: BlocBuilder<OfflinePackCubit, OfflinePackState>(
        builder: (context, state) {
          final offlinePack =
              state is OfflinePackLoaded ? state.offlinePack : null;
          final registry = offlinePack?.registry ?? {};
          final laws = offlinePack?.laws ?? {};
          final registryList = registry.values.toList();

          final filters = [
            'All Laws',
            ...registryList.map((r) => r.shortName ?? ''),
          ];

          final filteredList = controller.selectedFilter == 'All Laws'
              ? registryList
              : registryList
                  .where((r) => r.shortName == controller.selectedFilter)
                  .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              const _SearchBar(),
              14.verticalSpace,
              _FilterChips(
                filters: filters,
                selected: controller.selectedFilter,
                onSelect: controller.selectFilter,
              ),
              14.verticalSpace,
              _StatusBanner(offlinePack: offlinePack),
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
                    ...filteredList.map(
                      (reg) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: _LawItem(
                          registry: reg,
                          onTap: () => pushTo(
                            LawDetailScreen(
                              registry: reg,
                              entries: laws[reg.id] ?? [],
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
          );
        },
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

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
        separatorBuilder: (_, _) => 8.horizontalSpace,
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
                  color:
                      isSelected ? AppColors.primaryGreen : AppColors.border,
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
  const _StatusBanner({required this.offlinePack});

  final OfflinePack? offlinePack;

  @override
  Widget build(BuildContext context) {
    final isLoaded = offlinePack != null;
    return Container(
      width: double.infinity,
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isLoaded ? AppColors.lightGreen : AppColors.border,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 10.r,
            height: 10.r,
            decoration: BoxDecoration(
              color: isLoaded
                  ? AppColors.primaryGreen
                  : AppColors.secondaryText,
              shape: BoxShape.circle,
            ),
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (isLoaded ? 'All laws downloaded' : 'No offline pack').toText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                translate: false,
              ),
              4.verticalSpace,
              (isLoaded
                      ? 'Version ${offlinePack!.version ?? ''} · Read anytime offline'
                      : 'Download the pack to browse laws offline')
                  .toText(
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
  const _LawItem({required this.registry, required this.onTap});

  final LawRegistry registry;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (registry.name ?? '').toText(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    translate: false,
                  ),
                  if (registry.year != null)
                    '${registry.year}'.toText(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                      translate: false,
                    ),
                ],
              ),
            ),
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
