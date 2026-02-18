part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<CategoryLevel> navigationStack;
  final List<ModelItem>? selectedCategoryModels; // NEW: Models to display
  final bool isLoading;
  final String? error;

  const CategoryState({
    this.navigationStack = const [],
    this.selectedCategoryModels,
    this.isLoading = false,
    this.error,
  });

  // Current categories to display (if not showing models)
  List<CategoryResponse> get currentCategories {
    if (navigationStack.isEmpty) return [];
    return navigationStack.last.categories;
  }

  // Are we currently showing models instead of categories?
  bool get isShowingModels => selectedCategoryModels != null;

  // Check if we can go back
  bool get canGoBack => navigationStack.length > 1 || isShowingModels;

  // Current breadcrumb path
  List<String> get breadcrumbs {
    final crumbs = navigationStack.map((level) => level.title).toList();
    if (isShowingModels) {
      crumbs.add('Модели');
    }
    return crumbs;
  }

  @override
  List<Object?> get props => [navigationStack, selectedCategoryModels, isLoading, error];

  CategoryState copyWith({
    List<CategoryLevel>? navigationStack,
    List<ModelItem>? selectedCategoryModels,
    bool clearModels = false, // NEW: flag to clear models
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      navigationStack: navigationStack ?? this.navigationStack,
      selectedCategoryModels: clearModels ? null : (selectedCategoryModels ?? this.selectedCategoryModels),
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CategoryLevel extends Equatable {
  final String title;
  final List<CategoryResponse> categories;
  final int? parentCategoryId;

  const CategoryLevel({required this.title, required this.categories, this.parentCategoryId});

  @override
  List<Object?> get props => [title, categories, parentCategoryId];
}
