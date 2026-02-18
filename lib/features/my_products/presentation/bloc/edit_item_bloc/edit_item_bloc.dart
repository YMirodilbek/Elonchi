import 'package:elonchi/core/network/response_data.dart';
import 'package:elonchi/features/my_products/data/edit_item_request.dart';
import 'package:elonchi/features/my_products/data/product_item_response.dart';
import 'package:elonchi/features/my_products/domain/entities/sell_method.dart';
import 'package:elonchi/features/my_products/domain/repository/create_item_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_item_event.dart';
part 'edit_item_state.dart';

class EditItemBloc extends Bloc<EditItemEvent, EditItemState> {
  final CreateItemRepo repo;
  EditItemBloc(this.repo) : super(EditItemState()) {
    on<ChangePriceEvent>(onChangePrice);
    on<ChangeSellMethod>(onChangeSellMethod);
    on<ChangeMoneyTypeEvent>(onChangeMoneyType);
    on<EditItemRequestEvent>(onEditItem);
    on<ChangeTradeEvent>(onChangeTrade);
    on<InitDataEvent>(onInitData);
  }

  void onInitData(InitDataEvent event, Emitter<EditItemState> emit) {
    emit(state.copyWith(editItemRequest: event.request));
  }

  void onChangePrice(ChangePriceEvent event, Emitter<EditItemState> emit) {
    emit(state.copyWith(editItemRequest: state.editItemRequest?.copyWith(price: int.parse(event.price))));
  }

  void onChangeSellMethod(ChangeSellMethod event, Emitter<EditItemState> emit) {
    emit(state.copyWith(sellMethod: event.method));
  }

  void onChangeMoneyType(ChangeMoneyTypeEvent event, Emitter<EditItemState> emit) {
    emit(state.copyWith(editItemRequest: state.editItemRequest?.copyWith(moneyType: event.value)));
  }

  void onChangeTrade(ChangeTradeEvent event, Emitter<EditItemState> emit) {
    emit(state.copyWith(editItemRequest: state.editItemRequest?.copyWith(trade: event.value)));
  }

  void onEditItem(EditItemRequestEvent event, Emitter<EditItemState> emit) async {
    if (state.editItemRequest != null) {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      final response = await repo.editProduct(state.editItemRequest!);
      if (response.ok) {
        emit(state.copyWith(apiStatus: ApiStatus.success, productResponse: response.data));
      } else {
        emit(state.copyWith(apiStatus: ApiStatus.error));
      }
    }
  }
}
