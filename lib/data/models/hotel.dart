/// Shared hotel model for dashboard cards and hotel detail.
class Hotel {
  const Hotel({
    required this.id,
    required this.locationTitle,
    required this.distance,
    required this.availableDates,
    required this.price,
    required this.imageAsset,
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
  final String imageAsset;
  final String hostImageAsset;
  final String hotelName;
  final double rating;
  final int reviewCount;
  final String fullAddress;
  final String description;

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] as String,
      locationTitle: json['locationTitle'] as String,
      distance: json['distance'] as String,
      availableDates: json['availableDates'] as String,
      price: json['price'] as String,
      imageAsset: json['imageAsset'] as String,
      hostImageAsset: json['hostImageAsset'] as String,
      hotelName: json['hotelName'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      fullAddress: json['fullAddress'] as String,
      description: json['description'] as String,
    );
  }
}
