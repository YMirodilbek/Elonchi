import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/home/domain/repository/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watching_event.dart';
part 'watching_state.dart';

class WatchingBloc extends Bloc<WatchingEvent, WatchingState> {
  final HomeRepo repo;
  WatchingBloc(this.repo) : super(WatchingState()) {
    on<GetWatchingProductsEvent>(onGetWatchingProductsEvent);
  }

  void onGetWatchingProductsEvent(GetWatchingProductsEvent event, Emitter<WatchingState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));
    final result = await repo.getWatchingItems();
    if (result.ok) {
      emit(state.copyWith(status: ApiStatus.success));
    } else {
      emit(state.copyWith(status: ApiStatus.error));
    }
  }
}
