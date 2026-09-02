import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_background.dart';
import '../../../data/providers/hotel_providers.dart';
import '../../../l10n/app_strings.dart';
import '../utils/hotel_detail_metrics.dart';
import '../widgets/hotel_detail_header.dart';

class HotelView extends ConsumerWidget {
  const HotelView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = HotelDetailMetrics.of(context);
    final hotelAsync = ref.watch(selectedHotelProvider);
    final s = AppStrings.current;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: hotelAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white54),
          ),
          error: (e, _) => Center(
            child: Text(
              s.couldNotLoadHotel,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          data: (hotel) {
            if (hotel == null) {
              return Center(
                child: Text(
                  s.noHotelSelected,
                  style: const TextStyle(color: Colors.white70),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HotelDetailHeader(hotel: hotel, metrics: m),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      m.horizontalPadding,
                      20 * m.scale,
                      m.horizontalPadding,
                      m.navClearance,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.description, style: m.sectionTitleStyle),
                        SizedBox(height: 12 * m.scale),
                        Text(hotel.description, style: m.descriptionStyle),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
