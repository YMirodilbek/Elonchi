import 'package:elonchi/features/home/data/products_response.dart';

class SingleItemResponse {
  final Product? product;
  final List<Product>? products;

  const SingleItemResponse({this.product, this.products});

  factory SingleItemResponse.fromJson(Map<String, dynamic> json) {
    return SingleItemResponse(
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      products: (json['products'] as List?)?.map((e) => Product.fromJson(e)).toList(),
    );
  }

  SingleItemResponse copyWith({Product? product, List<Product>? products}) {
    return SingleItemResponse(product: product ?? this.product, products: products ?? this.products);
  }
}
