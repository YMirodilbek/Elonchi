part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class ChangeAdressEvent extends HomeEvent {
  final RegionResponse region;
  const ChangeAdressEvent({required this.region});
  @override
  List<Object> get props => [region];
}

final class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent();
  @override
  List<Object> get props => [];
}

final class GetBannerDataEvent extends HomeEvent {
  const GetBannerDataEvent();
  @override
  List<Object> get props => [];
}

final class GetRecentItems extends HomeEvent {
  const GetRecentItems();
  @override
  List<Object> get props => [];
}

final class ToggleLikeEvent extends HomeEvent {
  final int productId;
  const ToggleLikeEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
