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
