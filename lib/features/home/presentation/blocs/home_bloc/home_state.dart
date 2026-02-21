part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ApiStatus likingStatus;
  final ApiStatus bannerApiStatus;
  final ApiStatus categoriesApiStatus;
  final ApiStatus recentProductsApiStatus;
  final List<BannerDataResponse> bannerData;
  final RegionResponse? region;
  final List<CategoryResponse> categories;
  final List<Product> recentProducts;
  const HomeState({
    this.region,
    this.recentProducts = const [],
    this.categories = const [],
    this.bannerData = const [],
    this.likingStatus = ApiStatus.initial,
    this.bannerApiStatus = ApiStatus.initial,
    this.categoriesApiStatus = ApiStatus.initial,
    this.recentProductsApiStatus = ApiStatus.initial,
  });

  HomeState copyWith({
    List<Product>? recentProducts,
    ApiStatus? likingStatus,
    ApiStatus? bannerApiStatus,
    ApiStatus? categoriesApiStatus,
    ApiStatus? recentProductsApiStatus,
    RegionResponse? region,
    List<CategoryResponse>? categories,
    List<BannerDataResponse>? bannerData,
  }) {
    return HomeState(
      likingStatus: likingStatus ?? this.likingStatus,
      recentProducts: recentProducts ?? this.recentProducts,
      bannerApiStatus: bannerApiStatus ?? this.bannerApiStatus,
      categoriesApiStatus: categoriesApiStatus ?? this.categoriesApiStatus,
      recentProductsApiStatus: recentProductsApiStatus ?? this.recentProductsApiStatus,
      region: region ?? this.region,
      categories: categories ?? this.categories,
      bannerData: bannerData ?? this.bannerData,
    );
  }

  @override
  List<Object?> get props => [
    region,
    categories,
    bannerData,
    bannerApiStatus,
    categoriesApiStatus,
    recentProductsApiStatus,
    recentProducts,
    likingStatus,
  ];
}
