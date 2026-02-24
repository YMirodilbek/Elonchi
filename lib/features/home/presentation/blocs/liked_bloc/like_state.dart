part of 'like_bloc.dart';

class LikeState extends Equatable {
  final ApiStatus apiStatus;
  final ApiStatus likingStatus;
  final List<Product> products;

  const LikeState({
    this.apiStatus = ApiStatus.loading,
    this.likingStatus = ApiStatus.initial,
    this.products = const [],
  });

  @override
  List<Object> get props => [apiStatus, likingStatus, products];

  LikeState copyWith({ApiStatus? apiStatus, ApiStatus? likingStatus, List<Product>? products}) {
    return LikeState(
      apiStatus: apiStatus ?? this.apiStatus,
      likingStatus: likingStatus ?? this.likingStatus,
      products: products ?? this.products,
    );
  }
}
