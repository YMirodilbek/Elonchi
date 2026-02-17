import 'dart:io';

import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/domain/entities/selected_category.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:elonchi/features/my_products/domain/entities/condition.dart';

class CreateProductRequest {
  final Condition? condition;
  final String? contactname;
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
  final RegionResponse? region;
  final SelectedCategory? category;
  final ModelItem? selectedModel;
  final List<File>? images;

  const CreateProductRequest({
    this.condition = Condition.newProduct,
    this.contactname,
    this.selectedModel,
    this.title,
    this.price,
    this.moneyType = "UZS",
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
    Condition? condition,
    String? contactname,
    ModelItem? selectedModel,
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
    RegionResponse? region,
    SelectedCategory? category,
    List<File>? images,
  }) {
    return CreateProductRequest(
      condition: condition ?? this.condition,
      contactname: contactname ?? this.contactname,
      selectedModel: selectedModel ?? this.selectedModel,
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
