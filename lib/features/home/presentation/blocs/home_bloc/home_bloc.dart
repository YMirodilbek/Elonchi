import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/domain/categories_repo.dart';
import 'package:elonchi/features/home/data/banner_response.dart';
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
  }

  void onChangeAdressEvent(ChangeAdressEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(region: event.region));
  }

  void onGetCategoriesEvent(GetCategoriesEvent event, Emitter<HomeState> emit) async {
    final result = await categoriesRepo.getCategories();
    if (result.ok) {
      emit(state.copyWith(categories: result.data ?? []));
    }
  }

  void onGetBannerDataEvent(GetBannerDataEvent event, Emitter<HomeState> emit) async {
    final result = await repo.getBannerData();
    if (result.ok) {
      emit(state.copyWith(bannerData: result.data));
    }
  }
}
