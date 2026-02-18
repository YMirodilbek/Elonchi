import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';
import 'package:elonchi/features/my_products/domain/repository/my_items_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_items_event.dart';
part 'my_items_state.dart';

class MyItemsBloc extends Bloc<MyItemsEvent, MyItemsState> {
  final MyItemsRepo repository;
  MyItemsBloc(this.repository) : super(MyItemsState()) {
    on<GetMyItemsEvent>(onGetMyItems);
    on<UpdateItemEvent>(onUpdateItem);
  }

  void onGetMyItems(GetMyItemsEvent event, Emitter<MyItemsState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    final result = await repository.getItems();
    if (result.ok) {
      emit(state.copyWith(apiStatus: ApiStatus.success, items: result.data));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  void onUpdateItem(UpdateItemEvent event, Emitter<MyItemsState> emit) {
    final updatedItems = List<ProductResponse>.from(state.items);
    updatedItems[event.index] = event.product;
    emit(state.copyWith(items: updatedItems));
  }
}
