import 'package:elonchi/features/home/domain/entities/get_product_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersState()) {
    on<ChangeRegionEvent>(onSetRegion);
    on<ChangeCategoryEvent>(onSetCategory);
    on<ChangeMinPriceEvent>(onSetMinPrice);
    on<ChangeMaxPriceEvent>(onSetMaxPrice);
    on<ChangeTradeTypeEvent>(onSetTradeType);
    on<ChangeConditionEvent>(onSetCondition);
    on<InitFiltersEvent>(onInit);
    on<ClearFiltersEvent>(onClear);
  }

  void onSetRegion(ChangeRegionEvent event, Emitter<FiltersState> emit) {
    emit(
      state.copyWith(
        region: event.region,
        request: state.request.copyWith(region: event.regionId),
      ),
    );
  }

  void onSetCategory(ChangeCategoryEvent event, Emitter<FiltersState> emit) {
    emit(
      state.copyWith(
        request: state.request.copyWith(categoryId: event.categoryId, categoryName: event.category),
      ),
    );
  }

  void onSetMinPrice(ChangeMinPriceEvent event, Emitter<FiltersState> emit) {
    emit(state.copyWith(request: state.request.copyWith()));
  }

  void onSetMaxPrice(ChangeMaxPriceEvent event, Emitter<FiltersState> emit) {
    emit(state.copyWith(request: state.request.copyWith()));
  }

  void onSetTradeType(ChangeTradeTypeEvent event, Emitter<FiltersState> emit) {
    emit(state.copyWith(request: state.request.copyWith()));
  }

  void onSetCondition(ChangeConditionEvent event, Emitter<FiltersState> emit) {
    emit(state.copyWith(request: state.request.copyWith(condition: event.condition)));
  }

  void onInit(InitFiltersEvent event, Emitter<FiltersState> emit) {
    emit(state.copyWith(request: event.request, region: event.request.regionName));
  }

  void onClear(ClearFiltersEvent event, Emitter<FiltersState> emit) {
    emit(FiltersState(request: GetProductRequest()));
  }
}
