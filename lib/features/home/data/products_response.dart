class ProductsResponsePaginated {
  final List<Product>? products;
  final int? count;
  final String? next;
  const ProductsResponsePaginated({this.products, this.count, this.next});

  factory ProductsResponsePaginated.fromJson(Map<String, dynamic> json) {
    return ProductsResponsePaginated(
      count: json['count'] as int?,
      next: json['next'] as String?,
      products: (json['results'] as List?)?.map((e) => Product.fromJson(e)).toList(),
    );
  }

  ProductsResponsePaginated copyWith({List<Product>? products, int? count, String? next}) {
    return ProductsResponsePaginated(
      products: products ?? this.products,
      count: count ?? this.count,
      next: next ?? this.next,
    );
  }
}

class Product {
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

  const Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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

  Product copyWith({
    int? id,
    List<ProductImageResponse>? image,
    dynamic model,
    String? title,
    String? sold,
    String? price,
    String? moneyType,
    bool? trade,
    bool? exchange,
    bool? dostafca,
    String? address,
    String? phoneNumber,
    String? description,
    String? contactName,
    String? condition,
    bool? isActive,
    bool? isStatus,
    int? viewsCount,
    DateTime? createdAt,
    double? lat,
    double? lng,
    int? region,
    int? category,
    int? user,
  }) {
    return Product(
      id: id ?? this.id,
      image: image ?? this.image,
      model: model ?? this.model,
      title: title ?? this.title,
      sold: sold ?? this.sold,
      price: price ?? this.price,
      moneyType: moneyType ?? this.moneyType,
      trade: trade ?? this.trade,
      exchange: exchange ?? this.exchange,
      dostafca: dostafca ?? this.dostafca,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      contactName: contactName ?? this.contactName,
      condition: condition ?? this.condition,
      isActive: isActive ?? this.isActive,
      isStatus: isStatus ?? this.isStatus,
      viewsCount: viewsCount ?? this.viewsCount,
      createdAt: createdAt ?? this.createdAt,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      region: region ?? this.region,
      category: category ?? this.category,
      user: user ?? this.user,
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

  ProductImageResponse copyWith({int? id, String? image, DateTime? uploadedAt, int? user}) {
    return ProductImageResponse(
      id: id ?? this.id,
      image: image ?? this.image,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      user: user ?? this.user,
    );
  }
}
