import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/hotel.dart';

/// Loads demo hotels from a local JSON asset (easy to edit later).
class HotelDemoRepository {
  HotelDemoRepository._();

  static const _assetPath = 'assets/data/hotels.json';

  static Future<List<Hotel>> load() async {
    final raw = await rootBundle.loadString(_assetPath);
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => Hotel.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }
}
