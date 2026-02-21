import 'package:easy_debounce/easy_debounce.dart';
import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/home/domain/entities/get_product_request.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeRepo homeRepo;
  SearchBloc(this.homeRepo) : super(SearchState()) {
    on<SetCategoryEvent>(onSetCategory);
    on<SetRegionEvent>(onSetRegion);
    on<GetProducts>(onGetProducts);
    on<SearchProductsEvent>(onChangeQuert);
    on<DeleteQueryEvent>(onDeleteQuery);
    on<InitController>(onInitController);
    on<ToggleLikeEvent>(onToggleLikeEvent);
  }

  void onSetCategory(SetCategoryEvent event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        category: event.category,
        request: state.request.copyWith(categoryId: event.category.id),
      ),
    );
  }

  void onSetRegion(SetRegionEvent event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        region: event.region,
        request: state.request.copyWith(region: event.region.id),
      ),
    );
  }

  void onGetProducts(GetProducts event, Emitter<SearchState> emit) async {
    emit(state.copyWith(itemsLoadingStatus: ApiStatus.loading));
    final results = await homeRepo.getProducts(state.request);
    if (results.ok) {
      bool hasNext = true;
      if (results.data?.next == null || results.data!.next!.isEmpty) {
        hasNext = false;
      }

      emit(state.copyWith(products: results.data?.products ?? [], hasNext: hasNext));
    } else {
      emit(state.copyWith(products: []));
    }
    emit(state.copyWith(itemsLoadingStatus: ApiStatus.initial));
  }

  void onChangeQuert(SearchProductsEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(request: state.request.copyWith(query: event.query)));
    EasyDebounce.debounce('my-debouncer', Duration(milliseconds: 300), () {
      return add(const GetProducts());
    });
  }

  void onDeleteQuery(DeleteQueryEvent event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        request: state.request.copyWith(query: ''),
        searchController: state.searchController?..clear(),
      ),
    );
    add(const GetProducts());
  }

  void onInitController(InitController event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchController: event.controller));
  }

  void onToggleLikeEvent(ToggleLikeEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(likeLoadingStatus: ApiStatus.loading));
    final result = await homeRepo.likeItem(event.productId);
    if (result.ok) {
      final currentProducts = state.products;
      final index = currentProducts.indexWhere((element) => element.id == event.productId);
      if (index != -1) {
        final product = currentProducts[index];
        final updatedProduct = product.copyWith(iLike: !(product.iLike ?? false));
        final updatedProducts = List<Product>.from(currentProducts)..[index] = updatedProduct;
        emit(state.copyWith(products: updatedProducts));
      }
    }
    emit(state.copyWith(likeLoadingStatus: ApiStatus.initial));
  }
}
