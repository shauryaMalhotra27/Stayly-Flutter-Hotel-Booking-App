import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/debouncer.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/coming_soon_dialog.dart';
import '../../../data/models/hotel.dart';
import '../../../data/providers/hotel_providers.dart';
import '../../../l10n/app_strings.dart';
import '../utils/dashboard_metrics.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_search_bar.dart';
import '../widgets/property_card.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  static const _skeletonDuration = Duration(seconds: 2);

  final _searchController = TextEditingController();
  final _searchDebouncer = Debouncer();

  /// Skeleton cards on first open and after pull-to-refresh.
  bool _showSkeleton = true;

  /// Debounced query used to filter the hotel list.
  String _query = '';

  @override
  void initState() {
    super.initState();
    _scheduleSkeletonHide();
  }

  @override
  void dispose() {
    _searchDebouncer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scheduleSkeletonHide() {
    Future<void>.delayed(_skeletonDuration, () {
      if (mounted) setState(() => _showSkeleton = false);
    });
  }

  void _onSearchChanged(String value) {
    _searchDebouncer.run(() {
      if (!mounted) return;
      setState(() => _query = value.trim());
    });
  }

  void _clearSearch() {
    _searchDebouncer.cancel();
    _searchController.clear();
    setState(() => _query = '');
  }

  Future<void> _onRefresh() async {
    setState(() => _showSkeleton = true);
    ref.invalidate(hotelsProvider);
    await Future<void>.delayed(_skeletonDuration);
    await ref.read(hotelsProvider.future);
    if (mounted) setState(() => _showSkeleton = false);
  }

  void _openHotel(Hotel hotel) {
    ref.read(selectedHotelIdProvider.notifier).select(hotel.id);
    context.go('/hotel');
  }

  List<Hotel> _filterHotels(List<Hotel> hotels) {
    final q = _query.toLowerCase();
    if (q.isEmpty) return hotels;
    return hotels
        .where((h) {
          return h.locationTitle.toLowerCase().contains(q) ||
              h.distance.toLowerCase().contains(q) ||
              h.availableDates.toLowerCase().contains(q) ||
              h.price.toLowerCase().contains(q);
        })
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final m = DashboardMetrics.of(context);
    final hotelsAsync = ref.watch(hotelsProvider);
    final stillLoading = _showSkeleton || hotelsAsync.isLoading;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: m.headerTop),
              DashboardHeader(
                metrics: m,
                onMenuTap: () => KFDrawer.of(context)?.open(),
              ),
              SizedBox(height: m.searchTopGap),
              DashboardSearchBar(
                metrics: m,
                controller: _searchController,
                onChanged: _onSearchChanged,
                onClear: _clearSearch,
                onMicTap: () => ComingSoonDialog.show(context),
              ),
              SizedBox(height: m.listTopGap),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surfaceDark,
                  onRefresh: _onRefresh,
                  child: stillLoading
                      ? _CardList(
                          metrics: m,
                          children: const [
                            PropertyCard.skeleton(),
                            PropertyCard.skeleton(),
                          ],
                        )
                      : hotelsAsync.when(
                          data: (hotels) {
                            final filtered = _filterHotels(hotels);
                            if (filtered.isEmpty) {
                              return _NoResults(
                                metrics: m,
                                onReturn: _clearSearch,
                              );
                            }
                            return _CardList(
                              metrics: m,
                              children: [
                                for (final hotel in filtered)
                                  PropertyCard(
                                    hotel: hotel,
                                    onTap: () => _openHotel(hotel),
                                  ),
                              ],
                            );
                          },
                          loading: () => _CardList(
                            metrics: m,
                            children: const [
                              PropertyCard.skeleton(),
                              PropertyCard.skeleton(),
                            ],
                          ),
                          error: (e, _) => ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.all(m.horizontalPadding),
                            children: [
                              Text(
                                AppStrings.current.couldNotLoadHotels,
                                style: m.metaLabelStyle,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardList extends StatelessWidget {
  const _CardList({required this.metrics, required this.children});

  final DashboardMetrics metrics;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        m.horizontalPadding,
        0,
        m.horizontalPadding,
        m.navClearance,
      ),
      itemCount: children.length,
      separatorBuilder: (_, _) => SizedBox(height: m.cardGap),
      itemBuilder: (context, index) => children[index],
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults({required this.metrics, required this.onReturn});

  final DashboardMetrics metrics;
  final VoidCallback onReturn;

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        m.horizontalPadding,
        48 * m.scale,
        m.horizontalPadding,
        m.navClearance,
      ),
      children: [
        Text(
          AppStrings.current.noResultsFound,
          textAlign: TextAlign.center,
          style: m.cardTitleStyle,
        ),
        SizedBox(height: 16 * m.scale),
        Text(
          AppStrings.current.noResultsHint,
          textAlign: TextAlign.center,
          style: m.metaLabelStyle,
        ),
        SizedBox(height: 16 * m.scale),
        Center(
          child: GestureDetector(
            onTap: onReturn,
            child: Text(
              AppStrings.current.returnToList,
              style: m.metaValueStyle.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
