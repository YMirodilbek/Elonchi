class BannerDataResponse {
  final int? id;
  final String? image;

  const BannerDataResponse({this.id, this.image});

  factory BannerDataResponse.fromJson(Map<String, dynamic> json) {
    return BannerDataResponse(id: json['id'] as int, image: json['image'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image};
  }
}
