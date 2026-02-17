import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/domain/categories_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesRepo categoriesRepo;

  CategoryBloc({required this.categoriesRepo}) : super(const CategoryState()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<NavigateToSubCategoryEvent>(_onNavigateToSubCategory);
    on<NavigateBackEvent>(_onNavigateBack);
    on<ResetNavigationEvent>(_onResetNavigation);
    on<SelectModelEvent>(_onSelectModel);
  }

  Future<void> _onGetCategories(GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, clearModels: true));

    final result = await categoriesRepo.getCategories();

    if (result.ok) {
      final categories = result.data ?? [];
      final rootLevel = CategoryLevel(title: 'Категории', categories: categories, parentCategoryId: null);
      emit(state.copyWith(navigationStack: [rootLevel], isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false, error: result.error ?? 'Failed to load categories'));
    }
  }

  Future<void> _onNavigateToSubCategory(NavigateToSubCategoryEvent event, Emitter<CategoryState> emit) async {
    // Models exist - UI will handle popping, bloc does nothing
    if (event.category.models != null && event.category.models!.isNotEmpty) {
      return; // <-- just return, UI handles the pop
    }

    if (event.category.id == null) {
      emit(state.copyWith(error: 'Invalid category'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null, clearModels: true));

    final result = await categoriesRepo.getSubCategories(categoryId: event.category.id!);

    if (result.ok) {
      final subCategories = result.data ?? [];
      final newLevel = CategoryLevel(
        title: event.category.name ?? 'Подкатегории',
        categories: subCategories,
        parentCategoryId: event.category.id,
      );
      emit(state.copyWith(navigationStack: [...state.navigationStack, newLevel], isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false, error: result.error ?? 'Failed to load subcategories'));
    }
  }

  void _onNavigateBack(NavigateBackEvent event, Emitter<CategoryState> emit) {
    // If showing models, go back to categories
    if (state.isShowingModels) {
      emit(state.copyWith(clearModels: true));
      return;
    }

    // Otherwise navigate back in the stack
    if (state.canGoBack) {
      final updatedStack = state.navigationStack.sublist(0, state.navigationStack.length - 1);
      emit(state.copyWith(navigationStack: updatedStack));
    }
  }

  void _onResetNavigation(ResetNavigationEvent event, Emitter<CategoryState> emit) {
    if (state.navigationStack.isNotEmpty) {
      emit(state.copyWith(navigationStack: [state.navigationStack.first], clearModels: true));
    }
  }

  void _onSelectModel(SelectModelEvent event, Emitter<CategoryState> emit) {
    // Handle model selection - maybe close bottom sheet, save to form, etc.
    // For now, just close the bottom sheet by clearing everything
    // You might want to emit a different state or call a callback
  }
}
