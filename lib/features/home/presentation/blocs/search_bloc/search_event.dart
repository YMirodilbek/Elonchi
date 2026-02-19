part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

class SetCategoryEvent extends SearchEvent {
  final CategoryResponse category;
  const SetCategoryEvent(this.category);
  @override
  List<Object> get props => [category];
}

class SetRegionEvent extends SearchEvent {
  final RegionResponse region;
  const SetRegionEvent(this.region);
  @override
  List<Object> get props => [region];
}

class GetProducts extends SearchEvent {
  const GetProducts();
  @override
  List<Object> get props => [];
}

class SearchProductsEvent extends SearchEvent {
  final String query;
  const SearchProductsEvent(this.query);
  @override
  List<Object> get props => [query];
}

class DeleteQueryEvent extends SearchEvent {
  const DeleteQueryEvent();
  @override
  List<Object> get props => [];
}

class InitController extends SearchEvent {
  final TextEditingController controller;
  const InitController(this.controller);
  @override
  List<Object> get props => [controller];
}
