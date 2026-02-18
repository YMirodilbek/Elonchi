class ProductResponse {
  final int? id;
  final List<ProductImageResponse>? image;
  final dynamic model;
  final String? title;
  final String? sold;
  final String? price;
  final String? moneyType;
  final bool? trade;
  final bool? exchange;
  final bool? dostafca;
  final String? address;
  final String? phoneNumber;
  final String? description;
  final String? contactName;
  final String? condition;
  final bool? isActive;
  final bool? isStatus;
  final int? viewsCount;
  final DateTime? createdAt;
  final double? lat;
  final double? lng;
  final int? region;
  final int? category;
  final int? user;

  const ProductResponse({
    this.id,
    this.image,
    this.model,
    this.title,
    this.sold,
    this.price,
    this.moneyType,
    this.trade,
    this.exchange,
    this.dostafca,
    this.address,
    this.phoneNumber,
    this.description,
    this.contactName,
    this.condition,
    this.isActive,
    this.isStatus,
    this.viewsCount,
    this.createdAt,
    this.lat,
    this.lng,
    this.region,
    this.category,
    this.user,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as int?,
      image: (json['image'] as List?)?.map((e) => ProductImageResponse.fromJson(e)).toList(),
      model: json['model'],
      title: json['title'] as String?,
      sold: json['sold'] as String?,
      price: json['price'] as String?,
      moneyType: json['money_type'] as String?,
      trade: json['trade'] as bool?,
      exchange: json['exchange'] as bool?,
      dostafca: json['dostafca'] as bool?,
      address: json['address'] as String?,
      phoneNumber: json['phone_number'] as String?,
      description: json['description'] as String?,
      contactName: json['contact_name'] as String?,
      condition: json['condition'] as String?,
      isActive: json['is_active'] as bool?,
      isStatus: json['is_status'] as bool?,
      viewsCount: json['views_count'] as int?,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : null,
      lng: json['lan'] != null ? double.tryParse(json['lan'].toString()) : null,
      region: json['region'] as int?,
      category: json['category'] as int?,
      user: json['user'] as int?,
    );
  }
}

class ProductImageResponse {
  final int? id;
  final String? image;
  final DateTime? uploadedAt;
  final int? user;

  const ProductImageResponse({this.id, this.image, this.uploadedAt, this.user});

  factory ProductImageResponse.fromJson(Map<String, dynamic> json) {
    return ProductImageResponse(
      id: json['id'] as int?,
      image: json['image'] as String?,
      uploadedAt: json['uploaded_at'] != null ? DateTime.tryParse(json['uploaded_at']) : null,
      user: json['user'] as int?,
    );
  }
}
