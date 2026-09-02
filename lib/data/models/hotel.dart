/// Shared hotel model for dashboard cards and hotel detail.
class Hotel {
  const Hotel({
    required this.id,
    required this.locationTitle,
    required this.distance,
    required this.availableDates,
    required this.price,
    required this.imageAssets,
    required this.hostImageAsset,
    required this.hotelName,
    required this.rating,
    required this.reviewCount,
    required this.fullAddress,
    required this.description,
  });

  final String id;
  final String locationTitle;
  final String distance;
  final String availableDates;
  final String price;

  /// Gallery images; first entry is used on dashboard cards.
  final List<String> imageAssets;
  final String hostImageAsset;
  final String hotelName;
  final double rating;
  final int reviewCount;
  final String fullAddress;
  final String description;

  String get imageAsset => imageAssets.first;

  factory Hotel.fromJson(Map<String, dynamic> json) {
    final images = (json['imageAssets'] as List<dynamic>)
        .map((e) => e as String)
        .toList();
    assert(images.isNotEmpty, 'Hotel ${json['id']} needs imageAssets');

    return Hotel(
      id: json['id'] as String,
      locationTitle: json['locationTitle'] as String,
      distance: json['distance'] as String,
      availableDates: json['availableDates'] as String,
      price: json['price'] as String,
      imageAssets: images,
      hostImageAsset: json['hostImageAsset'] as String,
      hotelName: json['hotelName'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      fullAddress: json['fullAddress'] as String,
      description: json['description'] as String,
    );
  }
}
