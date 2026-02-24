import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final HomeRepo repo;
  LikeBloc(this.repo) : super(const LikeState()) {
    on<ToggleLikeEvent>(onToggleLikeEvent);
    on<GetLikedProductsEvent>(onGetLikedEvent);
  }

  void onGetLikedEvent(GetLikedProductsEvent event, Emitter<LikeState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await repo.getLikedItems();
    if (result.ok && result.data != null) {
      // Extract products from liked items and set iLike to true (since they're in liked list)
      final products = result.data!.results
          ?.map((item) => item.product?.copyWith(iLike: true))
          .whereType<Product>()
          .toList() ?? [];

      emit(state.copyWith(products: products, apiStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  void onToggleLikeEvent(ToggleLikeEvent event, Emitter<LikeState> emit) async {
    emit(state.copyWith(likingStatus: ApiStatus.loading));
    final result = await repo.likeItem(event.productId);
    if (result.ok) {
      final updatedProducts = state.products.map((product) {
        if (product.id == event.productId) {
          // If iLike is true (in liked list), toggling removes it (set to false)
          // If iLike is null/false (not in list), this shouldn't happen, but handle it
          return product.copyWith(iLike: false);
        }
        return product;
      }).toList();
      emit(state.copyWith(products: updatedProducts, likingStatus: ApiStatus.success));
    } else {
      emit(state.copyWith(likingStatus: ApiStatus.error));
    }
    emit(state.copyWith(likingStatus: ApiStatus.initial));
  }
}
