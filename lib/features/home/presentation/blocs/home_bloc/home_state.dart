part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<BannerDataResponse> bannerData;
  final RegionResponse? region;
  final List<CategoryResponse> categories;
  const HomeState({this.region, this.categories = const [], this.bannerData = const []});

  HomeState copyWith({
    RegionResponse? region,
    List<CategoryResponse>? categories,
    List<BannerDataResponse>? bannerData,
  }) {
    return HomeState(
      region: region ?? this.region,
      categories: categories ?? this.categories,
      bannerData: bannerData ?? this.bannerData,
    );
  }

  @override
  List<Object?> get props => [region, categories, bannerData];
}
