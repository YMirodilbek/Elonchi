import 'package:easy_debounce/easy_debounce.dart';
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
}
