import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/single_item/domain/repository/single_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'single_event.dart';
part 'single_state.dart';

class SingleBloc extends Bloc<SingleEvent, SingleState> {
  final SingleItemRepo singleItemRepo;
  SingleBloc(this.singleItemRepo) : super(const SingleState()) {
    on<GetSingleItemEvent>(onGetItemInfo);
    on<ToggleFavoriteEvent>(onFavoriteToggle);
    on<ToggleLikeRecomendedProduct>(onToggleLikeRecomennedItem);
    on<WatchProductEvent>(onWatchToggle);
  }

  void onGetItemInfo(GetSingleItemEvent event, Emitter<SingleState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final results = await singleItemRepo.getItem(event.itemId);
    if (results.ok && results.data != null) {
      emit(
        state.copyWith(
          status: ApiStatus.success,
          product: results.data!.product,
          relatedProducts: results.data!.products ?? [],
        ),
      );
    } else {
      emit(state.copyWith(status: ApiStatus.error));
    }
  }

  Future<void> likeItem(int itemId, Emitter<SingleState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await singleItemRepo.likeItem(itemId);
    if (result.ok) {
      emit(state.copyWith(product: state.product?.copyWith(iLike: true), likeApiStatus: ApiStatus.initial));
    }
  }

  Future<void> dislikeItem(int itemId, Emitter<SingleState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await singleItemRepo.likeItem(itemId);
    if (result.ok) {
      emit(state.copyWith(product: state.product?.copyWith(iLike: false), likeApiStatus: ApiStatus.initial));
    }
  }

  void onFavoriteToggle(ToggleFavoriteEvent event, Emitter<SingleState> emit) async {
    if (state.product?.iLike == true) {
      await dislikeItem(event.itemId, emit);
    } else {
      await likeItem(event.itemId, emit);
    }
  }

  void onToggleLikeRecomennedItem(ToggleLikeRecomendedProduct event, Emitter<SingleState> emit) async {
    final product = state.relatedProducts.firstWhere((element) => element.id == event.itemId);
    emit(state.copyWith(likeRelatedProductsApiStatus: ApiStatus.loading));
    if (product.iLike == true) {
      final result = await singleItemRepo.likeItem(event.itemId);
      if (result.ok) {
        final updatedProducts = state.relatedProducts.map((e) {
          if (e.id == event.itemId) {
            return e.copyWith(iLike: false);
          }
          return e;
        }).toList();
        emit(state.copyWith(relatedProducts: updatedProducts));
      }
    } else {
      final result = await singleItemRepo.likeItem(event.itemId);
      if (result.ok) {
        final updatedProducts = state.relatedProducts.map((e) {
          if (e.id == event.itemId) {
            return e.copyWith(iLike: true);
          }
          return e;
        }).toList();
        emit(state.copyWith(relatedProducts: updatedProducts));
      }
    }
    emit(state.copyWith(likeRelatedProductsApiStatus: ApiStatus.initial));
  }

  void onWatchToggle(WatchProductEvent event, Emitter<SingleState> emit) async {
    emit(state.copyWith(watchApiStatus: ApiStatus.loading));
    if (state.product?.isWatching == true) {
      final result = await singleItemRepo.deleteWatchingItem(event.itemId);
      if (result.ok) {
        emit(state.copyWith(product: state.product?.copyWith(isWatching: false)));
      }
    } else {
      final result = await singleItemRepo.watchItem(event.itemId);
      if (result.ok) {
        emit(state.copyWith(product: state.product?.copyWith(isWatching: true)));
      }
    }
    emit(state.copyWith(watchApiStatus: ApiStatus.initial));
  }
}
