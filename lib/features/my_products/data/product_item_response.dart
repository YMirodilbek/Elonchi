class ProductModel {
  final int? id;
  final List<String>? images;
  final String? title;
  final String? price;
  final String? moneyType;
  final bool? trade;
  final bool? exchange;
  final bool? dostafca;
  final String? address;
  final String? phoneNumber;
  final String? description;
  final bool? isActive;
  final bool? isStatus;
  final int? viewsCount;
  final String? createdAt;
  final String? lan;
  final String? lat;
  final String? region;
  final String? category;
  final int? user;

  const ProductModel({
    this.id,
    this.images,
    this.title,
    this.price,
    this.moneyType,
    this.trade,
    this.exchange,
    this.dostafca,
    this.address,
    this.phoneNumber,
    this.description,
    this.isActive,
    this.isStatus,
    this.viewsCount,
    this.createdAt,
    this.lan,
    this.lat,
    this.region,
    this.category,
    this.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      images: (json['image'] as List?)?.map((e) => e.toString()).toList(),
      title: json['title'],
      price: json['price'],
      moneyType: json['money_type'],
      trade: json['trade'],
      exchange: json['exchange'],
      dostafca: json['dostafca'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      description: json['description'],
      isActive: json['is_active'],
      isStatus: json['is_status'],
      viewsCount: json['views_count'],
      createdAt: json['created_at'],
      lan: json['lan'],
      lat: json['lat'],
      region: json['region'],
      category: json['category'],
      user: json['user'],
    );
  }
}
