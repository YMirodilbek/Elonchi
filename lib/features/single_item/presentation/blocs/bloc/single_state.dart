part of 'single_bloc.dart';

class SingleState extends Equatable {
  final ApiStatus watchApiStatus;
  final ApiStatus likeRelatedProductsApiStatus;
  final ApiStatus status;
  final ApiStatus likeApiStatus;
  final Product? product;
  final List<Product> relatedProducts;

  const SingleState({
    this.status = ApiStatus.initial,
    this.product,
    this.watchApiStatus = ApiStatus.initial,
    this.likeRelatedProductsApiStatus = ApiStatus.initial,
    this.relatedProducts = const [],
    this.likeApiStatus = ApiStatus.initial,
  });

  @override
  List<Object?> get props => [
    status,
    product,
    relatedProducts,
    likeApiStatus,
    likeRelatedProductsApiStatus,
    watchApiStatus,
  ];

  SingleState copyWith({
    ApiStatus? watchApiStatus,
    ApiStatus? likeRelatedProductsApiStatus,
    ApiStatus? status,
    Product? product,
    List<Product>? relatedProducts,
    ApiStatus? likeApiStatus,
  }) {
    return SingleState(
      watchApiStatus: watchApiStatus ?? this.watchApiStatus,
      likeRelatedProductsApiStatus: likeRelatedProductsApiStatus ?? this.likeRelatedProductsApiStatus,
      likeApiStatus: likeApiStatus ?? this.likeApiStatus,
      status: status ?? this.status,
      product: product ?? this.product,
      relatedProducts: relatedProducts ?? this.relatedProducts,
    );
  }
}
