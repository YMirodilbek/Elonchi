part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoryEvent {
  const GetCategoriesEvent();
}

class NavigateToSubCategoryEvent extends CategoryEvent {
  final CategoryResponse category;

  const NavigateToSubCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class NavigateBackEvent extends CategoryEvent {
  const NavigateBackEvent();
}

class ResetNavigationEvent extends CategoryEvent {
  const ResetNavigationEvent();
}

// NEW: Event when user selects a model
class SelectModelEvent extends CategoryEvent {
  final ModelItem model;

  const SelectModelEvent(this.model);

  @override
  List<Object?> get props => [model];
}
