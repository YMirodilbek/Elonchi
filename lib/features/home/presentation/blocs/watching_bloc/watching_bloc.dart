import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watching_event.dart';
part 'watching_state.dart';

class WatchingBloc extends Bloc<WatchingEvent, WatchingState> {
  final HomeRepo repo;

  WatchingBloc(this.repo) : super(const WatchingState()) {
    on<GetWatchingProductsEvent>(onGetWatchingEvent);
    on<ToggleWatchingEvent>(onToggleWatching);
  }

  void onGetWatchingEvent(GetWatchingProductsEvent event, Emitter<WatchingState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await repo.getWatchingItems();
    if (result.ok && result.data != null) {
      // Extract products from watching items
      final products = result.data!.results?.map((item) => item.product).whereType<Product>().toList() ?? [];

      emit(state.copyWith(products: products, apiStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  void onToggleWatching(ToggleWatchingEvent event, Emitter<WatchingState> emit) async {
    emit(state.copyWith(watchingStatus: ApiStatus.loading));
    final result = await repo.watchItem(event.productId);
    if (result.ok) {
      final updatedProducts = state.products.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(isWatching: !(product.isWatching ?? false));
        }
        return product;
      }).toList();
      emit(state.copyWith(products: updatedProducts, watchingStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(watchingStatus: ApiStatus.error));
    }
    emit(state.copyWith(watchingStatus: ApiStatus.initial));
  }
}
