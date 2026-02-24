part of 'watching_bloc.dart';

class WatchingState extends Equatable {
  final ApiStatus apiStatus;
  final ApiStatus watchingStatus;
  final List<Product> products;

  const WatchingState({
    this.apiStatus = ApiStatus.initial,
    this.watchingStatus = ApiStatus.initial,
    this.products = const [],
  });

  @override
  List<Object> get props => [apiStatus, watchingStatus, products];

  WatchingState copyWith({ApiStatus? apiStatus, ApiStatus? watchingStatus, List<Product>? products}) {
    return WatchingState(
      apiStatus: apiStatus ?? this.apiStatus,
      watchingStatus: watchingStatus ?? this.watchingStatus,
      products: products ?? this.products,
    );
  }
}
