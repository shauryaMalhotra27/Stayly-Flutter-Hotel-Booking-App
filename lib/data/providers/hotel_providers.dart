import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/hotel.dart';
import '../repositories/hotel_demo_repository.dart';

/// All demo hotels from JSON.
final hotelsProvider = FutureProvider<List<Hotel>>((ref) {
  return HotelDemoRepository.load();
});

/// Currently selected hotel id.
class SelectedHotelId extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String id) => state = id;
}

final selectedHotelIdProvider = NotifierProvider<SelectedHotelId, String?>(
  SelectedHotelId.new,
);

/// Selected hotel, or the first hotel if none selected yet.
final selectedHotelProvider = Provider<AsyncValue<Hotel?>>((ref) {
  final hotelsAsync = ref.watch(hotelsProvider);
  final selectedId = ref.watch(selectedHotelIdProvider);

  return hotelsAsync.whenData((hotels) {
    if (hotels.isEmpty) return null;
    if (selectedId == null) return hotels.first;
    return hotels.firstWhere(
      (h) => h.id == selectedId,
      orElse: () => hotels.first,
    );
  });
});
