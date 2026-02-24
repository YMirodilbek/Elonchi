part of 'filters_bloc.dart';

sealed class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

final class ChangeConditionEvent extends FiltersEvent {
  final String condition;
  const ChangeConditionEvent(this.condition);
  @override
  List<Object> get props => [condition];
}

final class ChangeRegionEvent extends FiltersEvent {
  final int regionId;
  final String region;
  const ChangeRegionEvent({required this.region, required this.regionId});
  @override
  List<Object> get props => [region, regionId];
}

final class ChangeCategoryEvent extends FiltersEvent {
  final int categoryId;
  final String category;
  const ChangeCategoryEvent({required this.category, required this.categoryId});
  @override
  List<Object> get props => [category, categoryId];
}

final class ChangeMinPriceEvent extends FiltersEvent {
  final int minPrice;

  const ChangeMinPriceEvent(this.minPrice);
  @override
  List<Object> get props => [minPrice];
}

final class ChangeMaxPriceEvent extends FiltersEvent {
  final int maxPrice;

  const ChangeMaxPriceEvent(this.maxPrice);
  @override
  List<Object> get props => [maxPrice];
}

final class ChangeTradeTypeEvent extends FiltersEvent {
  final String sort;

  const ChangeTradeTypeEvent(this.sort);
  @override
  List<Object> get props => [sort];
}

final class ClearFiltersEvent extends FiltersEvent {
  const ClearFiltersEvent();
  @override
  List<Object> get props => [];
}

final class InitFiltersEvent extends FiltersEvent {
  final GetProductRequest request;
  const InitFiltersEvent(this.request);
  @override
  List<Object> get props => [request];
}
