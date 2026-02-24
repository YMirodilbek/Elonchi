import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/domain/categories_repo.dart';
import 'package:elonchi/features/home/data/banner_response.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoriesRepo categoriesRepo;
  final HomeRepo repo;
  HomeBloc(this.repo, this.categoriesRepo) : super(HomeState()) {
    on<ChangeAdressEvent>(onChangeAdressEvent);
    on<GetCategoriesEvent>(onGetCategoriesEvent);
    on<GetBannerDataEvent>(onGetBannerDataEvent);
    on<GetRecentItems>(onGetRecentItems);
    on<ToggleLikeEvent>(onToggleLikeEvent);
  }

  void onChangeAdressEvent(ChangeAdressEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(region: event.region));
  }

  void onGetCategoriesEvent(GetCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(categoriesApiStatus: ApiStatus.loading));
    final result = await categoriesRepo.getCategories();
    if (result.ok) {
      emit(state.copyWith(categories: result.data ?? []));
    }
    emit(state.copyWith(categoriesApiStatus: ApiStatus.initial));
  }

  void onGetBannerDataEvent(GetBannerDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(bannerApiStatus: ApiStatus.loading));
    final result = await repo.getBannerData();
    if (result.ok) {
      emit(state.copyWith(bannerData: result.data));
    }
    emit(state.copyWith(bannerApiStatus: ApiStatus.initial));
  }

  void onGetRecentItems(GetRecentItems event, Emitter<HomeState> emit) async {
    emit(state.copyWith(recentProductsApiStatus: ApiStatus.loading));
    final result = await repo.getRecentItems();
    if (result.ok) {
      emit(state.copyWith(recentProducts: result.data?.products ?? []));
    }
    emit(state.copyWith(recentProductsApiStatus: ApiStatus.initial));
  }

  void onToggleLikeEvent(ToggleLikeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(likingStatus: ApiStatus.loading));
    final result = await repo.likeItem(event.productId);
    if (result.ok) {
      final updatedProducts = state.recentProducts.map((product) {
        if (product.id == event.productId) {
          return product.copyWith(iLike: !(product.iLike ?? false));
        }
        return product;
      }).toList();
      emit(state.copyWith(recentProducts: updatedProducts));
    }
    emit(state.copyWith(likingStatus: ApiStatus.initial));
  }
}
