import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/home/data/products_response.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final HomeRepo repo;
  LikeBloc(this.repo) : super(LikeState()) {
    // on<ToggleLikeEvent>(onToggleLikeEvent);
    on<GetLikedProductsEvent>(onGetLikedEvent);
  }

  void onGetLikedEvent(GetLikedProductsEvent event, Emitter<LikeState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final result = await repo.getLikedItems();
    if (result.ok) {
      emit(state.copyWith(status: ApiStatus.success));
    } else {
      emit(state.copyWith(status: ApiStatus.error));
    }
  }
}
