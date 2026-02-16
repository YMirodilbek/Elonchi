import 'dart:io';

class CreateProductRequest {
  final String? title;
  final String? price;
  final String? moneyType;
  final bool? trade;
  final bool? exchange;
  final bool? dostafca;
  final String? address;
  final String? phoneNumber;
  final String? description;
  final String? lan;
  final String? lat;
  final String? region;
  final String? category;
  final List<File>? images;

  const CreateProductRequest({
    this.title,
    this.price,
    this.moneyType,
    this.trade,
    this.exchange,
    this.dostafca,
    this.address,
    this.phoneNumber,
    this.description,
    this.lan,
    this.lat,
    this.region,
    this.category,
    this.images,
  });

  CreateProductRequest copyWith({
    String? title,
    String? price,
    String? moneyType,
    bool? trade,
    bool? exchange,
    bool? dostafca,
    String? address,
    String? phoneNumber,
    String? description,
    String? lan,
    String? lat,
    String? region,
    String? category,
    List<File>? images,
  }) {
    return CreateProductRequest(
      title: title ?? this.title,
      price: price ?? this.price,
      moneyType: moneyType ?? this.moneyType,
      trade: trade ?? this.trade,
      exchange: exchange ?? this.exchange,
      dostafca: dostafca ?? this.dostafca,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
      lan: lan ?? this.lan,
      lat: lat ?? this.lat,
      region: region ?? this.region,
      category: category ?? this.category,
      images: images ?? this.images,
    );
  }
}
